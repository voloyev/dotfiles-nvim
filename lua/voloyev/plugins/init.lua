return {
  -- themes
  --'fxn/vim-monochrome'
  --"voloyev/vim-monochrome"
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end
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
  "terryma/vim-multiple-cursors",
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({})
    end
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
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        javascript = { "eslint" },
        ruby = { "rubocop" },
        go = { "gofmt" }
      },
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({})
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    "scrooloose/nerdtree",
    dependencies = {

      "Xuyuanp/nerdtree-git-plugin",
      "majutsushi/tagbar",
    },
    config = function()
      vim.keymap.set("n", "<leader>nn", vim.cmd.NERDTreeFocus)
      vim.keymap.set("n", "<leader>nt", vim.cmd.NERDTree)
    end
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    opts = { keys = "etovxqpdygfblzhckisuran" },
    config = function()
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection

      vim.keymap.set('n', '<leader>hf', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', '<leader>hF', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set('', '<leader>ht', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', '<leader>hT', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
    end
  },
  {
    'nvim-pack/nvim-spectre',
    config = function()
      require("spectre").setup({})

      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = "Toggle Spectre"
      })
      vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = "Search current word"
      })
      vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = "Search current word"
      })
      vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = "Search on current file"
      })
    end
  }
}
