return {
  "mistweaverco/kulala.nvim",
  opts = {
    -- Desactivar el instalador interno de treesitter de kulala para no romper los symlinks de nvim-treesitter
    treesitter = {
      enable = false,
    },
  },
}
