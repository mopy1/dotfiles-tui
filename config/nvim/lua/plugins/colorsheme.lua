return {
  -- 1. Plugin "Dracula & Alucard" (soporta Dracula oscuro y Alucard claro)
  {
    "delvedor/dracula-alucard.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true, -- Fondo transparente para conservar la terminal
      overrides = function(colors)
        local hls = {
          -- Terminal integrada
          Terminal = { bg = "none" },

          -- Ventanas no activas (paneles laterales)
          NormalNC = { bg = "none" },

          -- Árbol de archivos (Neo-tree)
          NeoTreeNormal = { bg = "none" },
          NeoTreeNormalNC = { bg = "none" },
          NeoTreeEndOfBuffer = { bg = "none" },
          NeoTreeWinSeparator = { bg = "none" },
          NeoTreeSignColumn = { bg = "none" },

          -- Árbol de archivos (NvimTree)
          NvimTreeNormal = { bg = "none" },
          NvimTreeNormalNC = { bg = "none" },
          NvimTreeEndOfBuffer = { bg = "none" },

          -- Explorador y terminales flotantes de Snacks (LazyVim)
          SnacksNormal = { bg = "none" },
          SnacksNormalNC = { bg = "none" },
          SnacksPickerNormal = { bg = "none" },
          SnacksExplorerNormal = { bg = "none" },

          -- Ventanas flotantes generales
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Columnas laterales de signos y pliegues
          SignColumn = { bg = "none" },
          FoldColumn = { bg = "none" },

          -- Barra de estado transparente (sin barra ploma/gris de fondo)
          StatusLine = { bg = "none" },
          StatusLineNC = { bg = "none" },
        }

        -- En Modo Claro: eliminar fondo negro y tonos amarillos de las barras de pestañas superiores
        if vim.o.background == "light" then
          -- Barra de pestañas superior (BufferLine) limpia, blanca y sin negro
          hls.BufferLineFill = { bg = "#f4f5f7" }
          hls.BufferLineBackground = { bg = "#f4f5f7", fg = "#6b7280" }
          hls.BufferLineBufferSelected = { bg = "#ffffff", fg = "#111827", bold = true }
          hls.BufferLineBufferVisible = { bg = "#f4f5f7", fg = "#6b7280" }
          hls.BufferLineSeparator = { fg = "#e5e7eb", bg = "#f4f5f7" }
          hls.BufferLineSeparatorSelected = { fg = "#e5e7eb", bg = "#ffffff" }
          hls.BufferLineSeparatorVisible = { fg = "#e5e7eb", bg = "#f4f5f7" }
          hls.BufferLineIndicatorSelected = { fg = "#7053d6", bg = "#ffffff" }
          hls.BufferLineModified = { bg = "#f4f5f7", fg = "#d97706" }
          hls.BufferLineModifiedSelected = { bg = "#ffffff", fg = "#d97706" }
          hls.BufferLineModifiedVisible = { bg = "#f4f5f7", fg = "#d97706" }
          hls.BufferLineCloseButton = { bg = "#f4f5f7", fg = "#9ca3af" }
          hls.BufferLineCloseButtonSelected = { bg = "#ffffff", fg = "#111827" }
          hls.BufferLineCloseButtonVisible = { bg = "#f4f5f7", fg = "#9ca3af" }

          -- Pestañas nativas (TabLine)
          hls.TabLine = { bg = "#f4f5f7", fg = "#6b7280" }
          hls.TabLineSel = { bg = "#ffffff", fg = "#111827", bold = true }
          hls.TabLineFill = { bg = "#f4f5f7" }

          -- Separadores de ventanas suaves en gris neutro
          hls.WinSeparator = { fg = "#e5e7eb" }
        end

        return hls
      end,
    },
    config = function(_, opts)
      require("dracula").setup(opts)
      vim.cmd.colorscheme("dracula")
    end,
  },

  -- 2. Decirle a LazyVim que use "dracula" como el tema por defecto
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
