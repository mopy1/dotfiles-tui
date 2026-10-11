return {
  -- 1. Desactivar markdownlint / lsp diagnostics molestos para markdown
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- Ocultar diagnósticos en archivos markdown
      },
    },
  },

  -- Desactivar autocompletado emergente (blink.cmp) en archivos Markdown
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      enabled = function()
        return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
      end,
      sources = {
        per_filetype = {
          markdown = {},
        },
      },
    },
  },

  -- Desactivar sugerencias de IA (Supermaven) en archivos Markdown
  {
    "supermaven-inc/supermaven-nvim",
    optional = true,
    opts = function(_, opts)
      opts.ignore_filetypes = opts.ignore_filetypes or {}
      opts.ignore_filetypes["markdown"] = true
      table.insert(opts.ignore_filetypes, "markdown")
    end,
  },

  -- 2. Renderizado visual enriquecido para Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    opts = {
      heading = {
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        width = "full",
        left_pad = 0,
        right_pad = 0,
      },
      code = {
        sign = true,
        width = "block",
        right_pad = 1,
        border = "thin",
      },
      bullet = {
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰄲 " },
      },
      pipe_table = {
        preset = "none", -- Tablas cuadradas clásicas
        style = "full",
      },
    },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
      {
        "<leader>ml",
        function()
          local file = vim.fn.expand("%:p")
          if file == "" or vim.bo.filetype ~= "markdown" then
            Snacks.notify.warn("Abre o guarda un archivo Markdown primero")
            return
          end
          vim.cmd("write")
          Snacks.terminal({ "leaf", file }, {
            win = {
              style = "lazygit",
              width = 0,
              height = 0,
              border = "none",
            },
          })
        end,
        desc = "Abrir con Leaf (pantalla completa)",
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      local set_headings = function()
        local headings = {
          { fg = "#7aa2f7", bg = "#24293b" }, -- H1: Azul
          { fg = "#e0af68", bg = "#2e2a2d" }, -- H2: Ámbar / Naranja
          { fg = "#9ece6a", bg = "#272d2d" }, -- H3: Verde
          { fg = "#1abc9c", bg = "#1a2b32" }, -- H4: Teal / Cyan
          { fg = "#bb9af7", bg = "#2a283b" }, -- H5: Púrpura suave
          { fg = "#9d7cd8", bg = "#272538" }, -- H6: Violeta
        }
        for i, h in ipairs(headings) do
          -- Icono y barra de fondo
          vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, { fg = h.fg, bold = true })
          vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i .. "Bg", { bg = h.bg })

          -- Texto del encabezado (Treesitter y markdown estándar)
          vim.api.nvim_set_hl(0, "@markup.heading." .. i, { fg = h.fg, bold = true })
          vim.api.nvim_set_hl(0, "@markup.heading." .. i .. ".markdown", { fg = h.fg, bold = true })
          vim.api.nvim_set_hl(0, "markdownH" .. i, { fg = h.fg, bold = true })
        end
      end

      set_headings()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("RenderMarkdownCustomHeadingColors", { clear = true }),
        callback = set_headings,
      })
    end,
  },



  -- 3. Previsualización en vivo en el navegador (compatible con WSL2 para abrir el navegador de Windows)
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      if vim.fn.has("wsl") == 1 then
        vim.g.mkdp_browserfunc = "v:lua.open_browser_wsl"
        _G.open_browser_wsl = function(url)
          vim.fn.jobstart({ "cmd.exe", "/c", "start", "", url }, { detach = true })
        end
      end
    end,
  },
}
