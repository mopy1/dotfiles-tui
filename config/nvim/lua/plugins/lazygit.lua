return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    -- Personalización de la posición y altura de la ventana flotante de LazyGit
    local lazygit_window = require("lazygit.window")

    lazygit_window.open_floating_window = function()
      local scaling = vim.g.lazygit_floating_window_scaling_factor or 0.98
      local width = math.ceil(vim.o.columns * scaling)
      local col = math.ceil((vim.o.columns - width) / 2)

      -- Fila inicial: 0 (pegada arriba del todo en el tope de la pantalla)
      local row = 0
      -- Altura ajustada para no tapar la barra inferior de estado (Lualine) ni la línea de comandos
      local height = math.max(10, vim.o.lines - row - 4)

      local opts = {
        style = "minimal",
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
        border = vim.g.lazygit_floating_window_border_chars or { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      }

      if LAZYGIT_BUFFER == nil or vim.fn.bufwinnr(LAZYGIT_BUFFER) == -1 then
        LAZYGIT_BUFFER = vim.api.nvim_create_buf(false, true)
      else
        LAZYGIT_LOADED = true
      end

      local win = vim.api.nvim_open_win(LAZYGIT_BUFFER, true, opts)

      vim.bo[LAZYGIT_BUFFER].filetype = "lazygit"
      vim.bo[LAZYGIT_BUFFER].bufhidden = "hide"
      vim.wo[win].cursorcolumn = false
      vim.wo[win].signcolumn = "no"
      vim.api.nvim_set_hl(0, "LazyGitBorder", { link = "FloatBorder", default = true })
      vim.api.nvim_set_hl(0, "LazyGitFloat", { link = "NormalFloat", default = true })
      vim.wo[win].winhl = "FloatBorder:LazyGitBorder,NormalFloat:LazyGitFloat"
      vim.wo[win].winblend = vim.g.lazygit_floating_window_winblend or 0

      -- Reajustar automáticamente si se redimensiona la terminal
      vim.api.nvim_create_autocmd("VimResized", {
        callback = function()
          vim.defer_fn(function()
            if not vim.api.nvim_win_is_valid(win) then
              return
            end
            local new_width = math.ceil(vim.o.columns * scaling)
            local new_col = math.ceil((vim.o.columns - new_width) / 2)
            local new_height = math.max(10, vim.o.lines - row - 4)
            vim.api.nvim_win_set_config(win, {
              width = new_width,
              height = new_height,
              relative = "editor",
              row = row,
              col = new_col,
            })
          end, 20)
        end,
      })

      return win, LAZYGIT_BUFFER
    end
  end,
}
