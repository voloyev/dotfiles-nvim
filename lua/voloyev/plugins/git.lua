return {
  {
    "lewis6991/gitsigns.nvim",
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
    }
  },
}
