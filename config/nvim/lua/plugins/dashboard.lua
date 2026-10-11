return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.width = 37
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.header = [[
███▄ ▄███▓ ▒█████   ██▓███ ▓██   ██▓
▓██▒▀█▀ ██▒▒██▒  ██▒▓██░  ██▒▒██  ██▒
▓██    ▓██░▒██░  ██▒▓██░ ██▓▒ ▒██ ██░
▒██    ▒██ ▒██   ██░▒██▄█▓▒ ▒ ░ ▐██▓░
▒██▒   ░██▒░ ████▓▒░▒██▒ ░  ░ ░ ██▒▓░
░ ▒░   ░  ░░ ▒░▒░▒░ ▒▓▒░ ░  ░  ██▒▒▒ 
░  ░      ░  ░ ▒ ▒░ ░▒ ░     ▓██ ░▒░ 
░      ░   ░ ░ ░ ▒  ░░       ▒ ▒ ░░  
       ░       ░ ░           ░ ░     
                             ░ ░     ]]

      opts.dashboard.preset.keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
        -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
        { icon = "󰠮 ", key = "o", desc = "Obsidian Vault", action = ":lua Snacks.dashboard.pick('files', {cwd = '/mnt/c/Users/lmc/Documents/Obsidian'})" },
        -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
        -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      }
    end,
  },
}
