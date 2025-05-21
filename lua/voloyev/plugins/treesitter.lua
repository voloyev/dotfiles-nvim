return {
  "nvim-treesitter/nvim-treesitter-context",
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
