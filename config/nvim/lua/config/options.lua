-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spell = false
vim.g.lazyvim_inlay_hints = false

-- Clean Mode por defecto: pantalla limpia sin barra inferior ni distracciones
vim.g.clean_mode = true
vim.opt.laststatus = 0
vim.opt.showtabline = 0
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.statusline = "%#Normal# "

-- Detectar Obsidian Vault (.obsidian) como raíz de proyecto en LazyVim
vim.g.root_spec = { "lsp", { ".git", ".obsidian", "lua" }, "cwd" }

-- Ajuste de línea global (para que todo el texto entre en pantalla)
vim.opt.wrap = true -- Activa el salto de línea visual
vim.opt.linebreak = true -- Rompe por palabras completas (no a mitad de una palabra)
vim.opt.breakindent = true -- Mantiene la sangría/identación al hacer el salto de línea

-- Tema claro / oscuro (sincronizado con ~/.config/theme-mode, por defecto light)
local theme_file = vim.fn.expand("~/.config/theme-mode")
local f = io.open(theme_file, "r")
if f then
  local mode = f:read("*all"):gsub("%s+", "")
  f:close()
  if mode == "dark" or mode == "light" then
    vim.opt.background = mode
  else
    vim.opt.background = "light"
  end
else
  vim.opt.background = "light"
end


