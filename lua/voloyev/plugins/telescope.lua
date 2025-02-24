return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("ui-select")
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          file_browser = {
            hidden = { file_browser = true, folder_browser = true },
          },
        },
      })

      local telescope = require("telescope.builtin")
      vim.keymap.set("n", "<leader><leader>", telescope.find_files)
      vim.keymap.set("n", "<C-p>", telescope.git_files)
      vim.keymap.set("n", "<leader>ff", telescope.live_grep)
      vim.keymap.set("n", "<leader>ob", telescope.buffers)
      vim.keymap.set("n", "<leader>oh", telescope.help_tags)
      vim.keymap.set(
        "n",
        "<leader>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>",
        { noremap = true }
      )
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  'nvim-telescope/telescope-ui-select.nvim',
}
