return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Mover a la izquierda (Tmux/Nvim)" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Mover abajo (Tmux/Nvim)" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Mover arriba (Tmux/Nvim)" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Mover a la derecha (Tmux/Nvim)" },
  },
}
