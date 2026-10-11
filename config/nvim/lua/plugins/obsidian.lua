local vault_path = vim.fn.isdirectory("/mnt/c/Users/lmc/Documents/Obsidian") == 1
    and "/mnt/c/Users/lmc/Documents/Obsidian"
    or vim.fn.expand("~/Obsidian")

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = vault_path,
      },
    },
    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },
    mappings = {
      -- Navegar a la nota en el cursor ([[enlace]] o url)
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Alternar checkbox ([ ] -> [x])
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
    ui = {
      enable = false, -- Desactivado para que render-markdown.nvim gestione todo el renderizado visual sin conflictos
    },
  },
}
