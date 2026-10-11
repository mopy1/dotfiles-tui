--  keymaps de tmux para navegar
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Mover izquierda (Tmux/Nvim)" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Mover abajo (Tmux/Nvim)" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Mover arriba (Tmux/Nvim)" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Mover derecha (Tmux/Nvim)" })

-- keymaps para salir de modo editor o visor
vim.keymap.set("i", "jk", "<Esc>", { desc = "Salir de modo editor o visor (Esc)" })
vim.keymap.set("v", "jk", "<Esc>", { desc = "Salir del modo visor (Esc)" })

-- Movimiento rápido con Alt + h/j/k/l
vim.keymap.set({ "n", "v" }, "<M-j>", "5j", { desc = "Bajar 5 líneas rápido" })
vim.keymap.set({ "n", "v" }, "<M-k>", "5k", { desc = "Subir 5 líneas rápido" })
vim.keymap.set({ "n", "v" }, "<M-h>", "b", { desc = "Ir al inicio de la palabra" })
vim.keymap.set({ "n", "v" }, "<M-l>", "e", { desc = "Ir al final de la palabra" })

-- Alternar tema claro / oscuro (Alucard / Dracula) y sincronizar Tmux
vim.keymap.set("n", "<leader>tt", function()
  local new_mode = vim.o.background == "dark" and "light" or "dark"
  vim.o.background = new_mode
  vim.fn.system("toggle-theme " .. new_mode)
  local label = new_mode == "light" and "☀ Modo Claro (Alucard)" or "🌙 Modo Oscuro (Dracula)"
  vim.notify("Tema: " .. label, vim.log.levels.INFO)
end, { desc = "Alternar Modo Claro / Oscuro (Alucard / Dracula)" })

-- Clean Mode: Pantalla limpia sin barra inferior ni distracciones (activo por defecto)
local clean_active = true
local clean_saved = {
  laststatus = 3,
  showtabline = 2,
  ruler = true,
  showcmd = true,
  cmdheight = 1,
}
local clean_augroup = vim.api.nvim_create_augroup("CleanModeGroup", { clear = true })

-- Mantener statusline limpio en cada ventana mientras Clean Mode esté activo
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = clean_augroup,
  callback = function()
    if clean_active then
      vim.wo.statusline = "%#Normal# "
    end
  end,
})

local function apply_clean()
  local ok_lualine, lualine = pcall(require, "lualine")
  if ok_lualine then
    pcall(lualine.hide, { unhide = false })
  end

  vim.o.laststatus = 0
  vim.o.showtabline = 0
  vim.o.ruler = false
  vim.o.showcmd = false
  vim.o.cmdheight = 0
  vim.o.statusline = "%#Normal# "

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    pcall(function()
      vim.wo[win].statusline = "%#Normal# "
    end)
  end
end

local function apply_default()
  local ok_lualine, lualine = pcall(require, "lualine")
  if ok_lualine then
    pcall(lualine.hide, { unhide = true })
  end

  vim.o.laststatus = (clean_saved.laststatus and clean_saved.laststatus > 0) and clean_saved.laststatus or 3
  vim.o.showtabline = (clean_saved.showtabline and clean_saved.showtabline > 0) and clean_saved.showtabline or 2
  vim.o.ruler = clean_saved.ruler ~= false
  vim.o.showcmd = clean_saved.showcmd ~= false
  vim.o.cmdheight = clean_saved.cmdheight or 1
  if clean_saved.statusline then
    vim.o.statusline = clean_saved.statusline
  else
    vim.o.statusline = ""
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    pcall(function()
      vim.wo[win].statusline = ""
    end)
  end

  if ok_lualine then
    pcall(lualine.refresh)
  end
end

local function toggle_clean()
  clean_active = not clean_active
  vim.g.clean_mode = clean_active

  if clean_active then
    apply_clean()
    vim.notify("Clean mode", vim.log.levels.INFO)
  else
    apply_default()
    vim.notify("Default mode", vim.log.levels.INFO)
  end
end

vim.keymap.set("n", "<leader>z", toggle_clean, { desc = "Alternar Clean Mode (Espacio + z)" })

