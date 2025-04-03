return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({})
      vim.opt.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end,
  },
  "MunifTanjim/nui.nvim",
  "tpope/vim-markdown",
  "rust-lang/rust.vim",
  "pangloss/vim-javascript",
  "leafgarland/typescript-vim",
  "mattn/emmet-vim",
  "elixir-editors/vim-elixir",
  "ollykel/v-vim",
  "fatih/vim-go",
  "cespare/vim-toml",
  "zah/nim.vim",
  "joerdav/templ.vim",
  "rhysd/vim-crystal",
  "mboughaba/i3config.vim",
  "jmcantrell/vim-virtualenv",
  "mg979/vim-visual-multi",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({})
    end,
  },
  {
    "tpope/vim-rails",
    dependencies = {
      --"vim-ruby/vim-ruby",
      "slim-template/vim-slim",
      "tpope/vim-bundler",
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "eruby.yaml",
        command = "set filetype=yaml",
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({})
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    opts = { keys = "etovxqpdygfblzhckisuran" },
    config = function()
      local hop = require("hop")
      hop.setup({})
      vim.keymap.set("n", "<leader>hh", function()
        hop.hint_char1({ current_line_only = false })
      end, { remap = true })
      vim.keymap.set("n", "<leader>hH", function()
        hop.hint_char2()
      end, { remap = true })
      vim.keymap.set("n", "<leader>hv", function()
        hop.hint_vertical()
      end, { remap = true })
    end,
  },
  -- {
  -- 	"folke/flash.nvim",
  -- 	event = "VeryLazy",
  -- 	---@type Flash.Config
  -- 	opts = {},
  --    -- stylua: ignore
  --    keys = {
  --      { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --    },
  -- },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup({})

      vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = "Search current word",
      })
      vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = "Search on current file",
      })
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      })

      vim.keymap.set({ "n" }, "<leader>ss", function()
        require("grug-far").open({ transient = true })
      end, { desc = "Toggle Grug Far" })

      vim.keymap.set({ "n", "v" }, "<leader>sw", function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end, { desc = "Search current word" })

      vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
        require('grug-far').open({ visualSelectionUsage = 'operate-within-range' })
      end, { desc = 'grug-far: Search within range' })
    end,
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/w", "~/fun", "/" },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = {
          "icon",
          "permissions",
          "size",
          -- "mtime",
        },
        view_options = {
          show_hidden = true,
        },
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  "armyers/Vim-Jinja2-Syntax",
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python" }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
    end,

    -- Optional cmp-conjure integration
    dependencies = { "PaterJason/cmp-conjure" },
  },
  {
    "PaterJason/cmp-conjure",
    lazy = true,
    config = function()
      local cmp = require("cmp")
      local config = cmp.get_config()
      table.insert(config.sources, { name = "conjure" })
      return cmp.setup(config)
    end,
  },
  "tpope/vim-dispatch",
  "clojure-vim/vim-jack-in",
  "radenling/vim-dispatch-neovim",
  {
    "fasterius/simple-zoom.nvim",
    config = function()
      vim.keymap.set("n", "<leader>z", require("simple-zoom").toggle_zoom)
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
  {
    "johnfrankmorgan/whitespace.nvim",
    config = function()
      require("whitespace-nvim").setup({
        -- configuration options and their defaults

        -- `highlight` configures which highlight is used to display
        -- trailing whitespace
        highlight = "DiffDelete",

        -- `ignored_filetypes` configures which filetypes to ignore when
        -- displaying trailing whitespace
        ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },

        -- `ignore_terminal` configures whether to ignore terminal buffers
        ignore_terminal = true,

        -- `return_cursor` configures if cursor should return to previous
        -- position after trimming whitespace
        return_cursor = true,
      })

      -- remove trailing whitespace with a keybinding
      vim.keymap.set("n", "<Leader>t", require("whitespace-nvim").trim)
    end,
  },
}
