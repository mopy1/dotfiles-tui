return {
  -- Plugin principal para desarrollo de Flutter en Neovim
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = true,
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = "Comment",
        prefix = "// ",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "tabedit",
      },
      lsp = {
        color = {
          enabled = true,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
      },
    },
    keys = {
      { "<leader>F", "", desc = "+flutter" },
      { "<leader>Fr", "<cmd>FlutterRun<cr>", desc = "Run Flutter App" },
      { "<leader>Fd", "<cmd>FlutterDevices<cr>", desc = "Flutter Devices" },
      { "<leader>Fe", "<cmd>FlutterEmulators<cr>", desc = "Flutter Emulators" },
      { "<leader>Fl", "<cmd>FlutterReload<cr>", desc = "Hot Reload" },
      { "<leader>FR", "<cmd>FlutterRestart<cr>", desc = "Hot Restart" },
      { "<leader>Fq", "<cmd>FlutterQuit<cr>", desc = "Quit Flutter App" },
      { "<leader>FL", "<cmd>FlutterLogToggle<cr>", desc = "Toggle Dev Log" },
      { "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", desc = "Toggle Widget Outline" },
      { "<leader>Ft", "<cmd>FlutterDevTools<cr>", desc = "Open DevTools" },
      { "<leader>Fp", "<cmd>FlutterPubGet<cr>", desc = "Flutter Pub Get" },
      { "<leader>Fu", "<cmd>FlutterPubUpgrade<cr>", desc = "Flutter Pub Upgrade" },
    },
  },

  -- Previsualización inline de iconos Material
  {
    "sidlatau/flutter-icons.nvim",
    ft = "dart",
    opts = {},
  },

  -- Resaltado de sintaxis con Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "dart" })
      end
    end,
  },

  -- Formateador de código con conform (dart_format al guardar)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        dart = { "dart_format" },
      },
    },
  },
}
