local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  "MunifTanjim/nui.nvim",
  -- themes
  --'fxn/vim-monochrome'
  --"voloyev/vim-monochrome"
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true }
  },
  "mboughaba/i3config.vim",

  "scrooloose/nerdtree",
  "Xuyuanp/nerdtree-git-plugin",

  "ervandew/supertab",
  "majutsushi/tagbar",

  "terryma/vim-multiple-cursors",
  "lewis6991/gitsigns.nvim",
  {
    'numToStr/Comment.nvim',
    opts = {}
  },
  "tpope/vim-markdown",


  -- rust related

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      extensions = {
        file_browser = {
          grouped = true
        }
      }
    }
  },
  -- Optional dependencies for telescope
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  -- Ruby and Rails
  "vim-ruby/vim-ruby",
  "tpope/vim-bundler",
  {
    "tpope/vim-rails",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "eruby.yaml",
        command = "set filetype=yaml",
      })
    end
  },
  -- Javascript
  -- python
  "jmcantrell/vim-virtualenv",


  -- Elixir
  "rust-lang/rust.vim",
  "pangloss/vim-javascript",
  "leafgarland/typescript-vim",
  "elixir-editors/vim-elixir",
  "ollykel/v-vim",
  "fatih/vim-go",
  "cespare/vim-toml",
  "zah/nim.vim",
  "slim-template/vim-slim",
  "joerdav/templ.vim",
  "rhysd/vim-crystal",

  "mbbill/undotree",
  "tpope/vim-fugitive",
  "mattn/emmet-vim",
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    opts = { keys = "etovxqpdygfblzhckisuran" }
  },
  "honza/vim-snippets",
  "dcampos/nvim-snippy",
  "dcampos/cmp-snippy",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/playground",
  "ThePrimeagen/harpoon",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" }
  },
  "leoluz/nvim-dap-go",
  "theHamsta/nvim-dap-virtual-text",
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  "RRethy/nvim-treesitter-endwise",
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
  "sindrets/diffview.nvim",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },
  'nvimtools/none-ls.nvim',
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  "mg979/vim-visual-multi",
 })


require("telescope").load_extension("file_browser")
require("lualine").setup({
  options = {
    theme = "everforest",
    section_separators = '',
    component_separators = '',
  },
})


require("ibl").setup({})


local hop = require('hop')
local directions = require('hop.hint').HintDirection
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
