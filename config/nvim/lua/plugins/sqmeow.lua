return {
  "2giosangmitom/sqmeow.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  version = "*",
  build = function()
    if not require("sqmeow.install").resolve() then
      require("sqmeow").install()
    end
  end,
  opts = {},
  cmd = "Sqmeow",
  ft = { "sql" },
  keys = {
    { "<leader>Dd", "<cmd>Sqmeow toggle<cr>", desc = "Toggle Sqmeow" },
    { "<leader>Dc", "<cmd>Sqmeow cancel<cr>", desc = "Cancel Query" },
    { "<leader>Da", "<cmd>Sqmeow add<cr>", desc = "Add Connection" },
    { "<leader>Ds", "<cmd>Sqmeow scratch<cr>", desc = "New Scratchpad" },
    { "<leader>De", "<cmd>Sqmeow execute<cr>", desc = "Execute buffer/selection" },
  },
  config = function(_, opts)
    require("sqmeow").setup(opts)

    -- Auto-vincular cualquier archivo .sql del proyecto para ejecutar con <CR> y <leader>E
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql" },
      callback = function(ev)
        pcall(function()
          require("sqmeow.ui.editor").attach(ev.buf, nil)
          require("sqmeow.ui.editor").update_winbar()
        end)
      end,
    })
  end,
}
