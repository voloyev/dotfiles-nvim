return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,         -- No limit
        trim_scope = "outer",  -- Show the outer scope
        min_window_height = 0, -- No minimum window height
        mode = "cursor",       -- Show context at cursor position
      })
    end
  },
  "nvim-treesitter/playground",
  "RRethy/nvim-treesitter-endwise",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "c", "ruby", "python", "elixir", "lua", "rust",
          "lua", "haskell", "javascript", "typescript", "python",
          "ocaml", "html", "svelte", "yaml", "gleam", "terraform",
          "scheme", "clojure", "zig", "go", "hcl"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        endwise = {
          enable = true,
        },
      })
    end
  }
}
