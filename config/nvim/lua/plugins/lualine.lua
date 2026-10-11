return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}

    -- Tema dinámico de alta legibilidad para Lualine adaptado a Modo Claro (blanco/neutro) y Modo Oscuro
    opts.options.theme = function()
      if vim.o.background == "light" then
        return {
          normal = {
            a = { bg = "#7053d6", fg = "#ffffff", gui = "bold" },
            b = { bg = "#eef0f3", fg = "#111827", gui = "bold" },
            c = { bg = "#ffffff", fg = "#111827" },
          },
          insert = {
            a = { bg = "#16a34a", fg = "#ffffff", gui = "bold" },
            b = { bg = "#eef0f3", fg = "#111827", gui = "bold" },
            c = { bg = "#ffffff", fg = "#111827" },
          },
          visual = {
            a = { bg = "#db2777", fg = "#ffffff", gui = "bold" },
            b = { bg = "#eef0f3", fg = "#111827", gui = "bold" },
            c = { bg = "#ffffff", fg = "#111827" },
          },
          replace = {
            a = { bg = "#dc2626", fg = "#ffffff", gui = "bold" },
            b = { bg = "#eef0f3", fg = "#111827", gui = "bold" },
            c = { bg = "#ffffff", fg = "#111827" },
          },
          command = {
            a = { bg = "#0284c7", fg = "#ffffff", gui = "bold" },
            b = { bg = "#eef0f3", fg = "#111827", gui = "bold" },
            c = { bg = "#ffffff", fg = "#111827" },
          },
          inactive = {
            a = { bg = "#f8f9fa", fg = "#9ca3af", gui = "bold" },
            b = { bg = "#f8f9fa", fg = "#9ca3af" },
            c = { bg = "#f8f9fa", fg = "#9ca3af" },
          },
        }
      else
        return {
          normal = {
            a = { bg = "#bd93f9", fg = "#282a36", gui = "bold" },
            b = { bg = "#44475a", fg = "#f8f8f2", gui = "bold" },
            c = { bg = "#21222c", fg = "#f8f8f2" },
          },
          insert = {
            a = { bg = "#50fa7b", fg = "#282a36", gui = "bold" },
            b = { bg = "#44475a", fg = "#f8f8f2", gui = "bold" },
            c = { bg = "#21222c", fg = "#f8f8f2" },
          },
          visual = {
            a = { bg = "#ff79c6", fg = "#282a36", gui = "bold" },
            b = { bg = "#44475a", fg = "#f8f8f2", gui = "bold" },
            c = { bg = "#21222c", fg = "#f8f8f2" },
          },
          replace = {
            a = { bg = "#ff5555", fg = "#282a36", gui = "bold" },
            b = { bg = "#44475a", fg = "#f8f8f2", gui = "bold" },
            c = { bg = "#21222c", fg = "#f8f8f2" },
          },
          command = {
            a = { bg = "#ffb86c", fg = "#282a36", gui = "bold" },
            b = { bg = "#44475a", fg = "#f8f8f2", gui = "bold" },
            c = { bg = "#21222c", fg = "#f8f8f2" },
          },
          inactive = {
            a = { bg = "#21222c", fg = "#6272a4", gui = "bold" },
            b = { bg = "#21222c", fg = "#6272a4" },
            c = { bg = "#21222c", fg = "#6272a4" },
          },
        }
      end
    end
  end,
  config = function(_, opts)
    require("lualine").setup(opts)
    if vim.g.clean_mode ~= false then
      pcall(require("lualine").hide, { unhide = false })
      vim.opt.laststatus = 0
    end
  end,
}
