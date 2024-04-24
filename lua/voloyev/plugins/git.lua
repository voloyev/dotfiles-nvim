return {
  {
    {
      "lewis6991/gitsigns.nvim",
      config = function()
        require('gitsigns').setup({})

        vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      end
    },
    {
      "tpope/vim-fugitive",
      config = function()
        vim.keymap.set("n", "<Leader>gg", vim.cmd.Git)
      end
    },
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
    {
      'f-person/git-blame.nvim',
      config = function()
        require('gitblame').setup({})
      end
    }
  },
}
