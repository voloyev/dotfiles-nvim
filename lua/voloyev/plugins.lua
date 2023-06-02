return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("rstacruz/sparkup")
	use("MunifTanjim/nui.nvim")

	--use 'fxn/vim-monochrome'
	use("voloyev/vim-monochrome")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("mboughaba/i3config.vim")

	use("scrooloose/nerdtree")
	use("Xuyuanp/nerdtree-git-plugin")

	use("ervandew/supertab")
	use("majutsushi/tagbar")

	use("terryma/vim-multiple-cursors")
	use("lewis6991/gitsigns.nvim")
	use("haya14busa/incsearch.vim")
	use("preservim/nerdcommenter")
	use("tpope/vim-markdown")
	use("townk/vim-autoclose")

	use("Shougo/deoplete.nvim")

	use("vim-syntastic/syntastic")
	use("tmhedberg/SimpylFold")

	-- rust related
	use("rust-lang/rust.vim")
	use("neovim/nvim-lspconfig")
	use("simrat39/rust-tools.nvim")

	-- telescope
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })
	-- Optional dependencies for telescope
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	-- Ruby and Rails
	use("vim-ruby/vim-ruby")
	use("tpope/vim-bundler")
	use("tpope/vim-rails")
	use("tpope/vim-surround")
	use("tpope/vim-endwise")
	use("tpope/vim-fugitive")

	use("nathanaelkane/vim-indent-guides")
	use("vimwiki/vimwiki")
	use("stephpy/vim-yaml")
	use("mattn/emmet-vim")

	-- Javascript
	use("pangloss/vim-javascript")
	use("leafgarland/typescript-vim")
	use("maxmellon/vim-jsx-pretty")
	use("prettier/vim-prettier")

	-- python
	use("python-mode/python-mode")
	use("vim-scripts/indentpython.vim")
	use("jmcantrell/vim-virtualenv")
	use("psf/black")

	use("mileszs/ack.vim")
	use("rhysd/vim-crystal")

	-- Elixir
	use("elixir-editors/vim-elixir")
	use("mhinz/vim-mix-format")
	use("slashmili/alchemist.vim")

	use("ollykel/v-vim")
	use("fatih/vim-go")
	use("cespare/vim-toml")
	use("zah/nim.vim")

	use("mbbill/undotree")
	use("morhetz/gruvbox")

	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("jose-elias-alvarez/null-ls.nvim")
end)
