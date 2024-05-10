return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = {
      extensions = {
        file_browser = {
          grouped = true,
          hidden = true
        }
      }
    },
    config = function()
      require("telescope").load_extension("file_browser")
      local telescope = require("telescope.builtin")
      vim.keymap.set("n", "<leader><leader>", telescope.find_files)
      vim.keymap.set("n", "<C-p>", telescope.git_files)
      vim.keymap.set("n", "<leader>ff", telescope.live_grep)
      vim.keymap.set("n", "<leader>ob", telescope.buffers)
      vim.keymap.set("n", "<leader>oh", telescope.help_tags)
      vim.keymap.set(
        "n",
        "<leader>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { noremap = true }
      )
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
}
