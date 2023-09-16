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
  "rstacruz/sparkup",
  "MunifTanjim/nui.nvim",
  --'fxn/vim-monochrome'
  --"voloyev/vim-monochrome"
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
  --	"preservim/nerdcommenter",
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  "tpope/vim-markdown",


  -- rust related
  "rust-lang/rust.vim",
  "simrat39/rust-tools.nvim",

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  -- Optional dependencies for telescope
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  -- Ruby and Rails
  "vim-ruby/vim-ruby",
  "tpope/vim-bundler",
  "tpope/vim-rails",
  "tpope/vim-endwise",
  "tpope/vim-fugitive",

  "stephpy/vim-yaml",
  "mattn/emmet-vim",

  -- Javascript
  "pangloss/vim-javascript",
  "leafgarland/typescript-vim",
  "maxmellon/vim-jsx-pretty",
  "prettier/vim-prettier",

  -- python
  "python-mode/python-mode",
  "vim-scripts/indentpython.vim",
  "jmcantrell/vim-virtualenv",
  "psf/black",

  "mileszs/ack.vim",
  "rhysd/vim-crystal",

  -- Elixir
  "elixir-editors/vim-elixir",
  "mhinz/vim-mix-format",
  "slashmili/alchemist.vim",

  "ollykel/v-vim",
  "fatih/vim-go",
  "cespare/vim-toml",
  "zah/nim.vim",

  "mbbill/undotree",
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  },

  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
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
    build = ":TSUpdate"
  },
  "nvim-treesitter/playground",
  "jose-elias-alvarez/null-ls.nvim",
  "ThePrimeagen/harpoon",
  "lukas-reineke/indent-blankline.nvim",
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
    'stevearc/conform.nvim',
    opts = {},
  }
})

require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
require('Comment').setup()
require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    "c", "ruby", "python", "elixir", "lua", "rust",
    "lua", "haskell", "javascript", "typescript", "python", "ocaml", "html", "svelte"
  },
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true }
})

local telescope = require("telescope")
telescope.setup({
  extensions = {
    file_browser = {
      grouped = true
    }
  }
})
telescope.load_extension("file_browser")
require('nvim-treesitter.configs').setup {
  endwise = {
    enable = true,
  },
}

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { "eslint" },
    ruby = { "rubocop" },
    go = { "gofmt" }
  },
})

