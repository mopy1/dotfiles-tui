-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Disable automatic spellcheck & wrapping forced by LazyVim on text/markdown files
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Desactivar errores de linter, autocompletado y ocultamiento (conceal) para ver Markdown 100% plano
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.diagnostic.enable(false, { bufnr = 0 })
    vim.b.completion = false
    vim.opt_local.conceallevel = 0
  end,
})

-- Sincronizar tema claro / oscuro automáticamente al ganar foco
vim.api.nvim_create_autocmd("FocusGained", {
  desc = "Sincronizar fondo claro/oscuro desde ~/.config/theme-mode",
  callback = function()
    local f = io.open(vim.fn.expand("~/.config/theme-mode"), "r")
    if f then
      local mode = f:read("*all"):gsub("%s+", "")
      f:close()
      if (mode == "light" or mode == "dark") and vim.o.background ~= mode then
        vim.o.background = mode
      end
    end
  end,
})

-- Cambiar CWD al abrir Neovim pasando una carpeta como argumento (ej. nvim /path/to/vault)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg and arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.fn.chdir(arg)
    end
  end,
})
