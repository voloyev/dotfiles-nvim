return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier", "eslint" },
          ruby = { "rubocop" },
          go = { "gofmt" },
          hcl = { "packer_fmt" },
          terraform = { "terraform_fmt" },
          tfvars = { "terraform_fmt" },
          ["terraform-vars"] = { "terraform_fmt" },
        },
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set({ "n", "v" }, "<leader>F", function()
        conform.format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("inlay-hints").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local telescope = require("telescope.builtin")
      local trouble = require("trouble")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("ansiblels", {
        filetypes = { "yml", "yaml" },
      })
      vim.lsp.enable('ansiblels')
      vim.lsp.enable('gleam')
      vim.lsp.enable('html')
      --
      -- lspconfig.pyright.setup({
      -- 	capabilities = capabilities,
      -- })

      vim.lsp.config('pylyzer', {
        settings = {
          python = {
            inlayHints = true,
          },
        },
      })
      vim.lsp.enable('pylyzer')
      vim.lsp.enable('ruff')

      vim.lsp.config('clangd', {
        capabilities = capabilities,
        settings = {
          clangd = {
            InlayHints = {
              Designators = true,
              Enabled = true,
              ParameterNames = true,
              DeducedTypes = true,
            },
            fallbackFlags = { "-std=c++20" },
          },
        }
      })
      vim.lsp.enable('clangd')

      vim.lsp.config('ts_ls', {
        root_dir = lspconfig.util.root_pattern("package.json"),
      })
      vim.lsp.enable('ts_ls')

      vim.lsp.config('denols', {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        settings = {
          deno = {
            inlayHints = {
              parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enable = true },
              enumMemberValues = { enabled = true },
            },
          }
        }
      })
      vim.lsp.enable('denols')

      vim.lsp.enable('solargraph')
      vim.lsp.enable('ruby_lsp')

      vim.lsp.config('zls', {
        -- capabilities = capabilities,
        single_file_support = true,
        settings = {
          zls = {
            enable_inlay_hints = true,
            inlay_hints_show_builtin = true,
            inlay_hints_exclude_single_argument = true,
            inlay_hints_hide_redundant_param_names = false,
            inlay_hints_hide_redundant_param_names_last_token = false,
          },
        },
      })
      vim.lsp.enable('zls')
      vim.lsp.enable('ocamllsp')

      vim.lsp.config('svelte', {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })
      vim.lsp.enable('svelte')

      vim.lsp.enable('templ')
      vim.filetype.add({ extension = { templ = "templ" } })

      vim.lsp.config('tailwindcss', {
        capabilities = capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } },
      })
      vim.lsp.enable('tailwindcss')

      vim.lsp.config('emmet_ls', {
        capabilities = capabilities,
        filetypes = {
          "css",
          "eruby",
          "html",
          "javascript",
          "javascriptreact",
          "less",
          "sass",
          "scss",
          "svelte",
          "pug",
          "typescriptreact",
          "vue",
          "react",
        },
        init_options = {
          html = {
            options = {
              -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
              ["bem.enabled"] = true,
            },
          },
        },
      })
      vim.lsp.enable('emmet_ls')

      vim.lsp.config('gopls', {
        cmd = { "gopls", "serve" },
        settings = {
          gopls = {
            hints = {
              rangeVariableTypes = true,
              parameterNames = true,
              constantValues = true,
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              functionTypeParameters = true,
            },
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })
      vim.lsp.enable('gopls')
      vim.lsp.enable('jsonls')

      vim.lsp.config('lexical', {
        cmd = { "/home/voloyev/w/elixir/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
        root_dir = function(fname)
          return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
        end,
        filetypes = { "elixir", "eelixir", "heex" },
      })
      vim.lsp.enable('lexical')

      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = false,
            },
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          },
        },
      })
      vim.lsp.enable('rust_analyzer')

      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          })
        end,
        settings = {
          Lua = {
            hint = {
              enable = true, -- necessary
            }
          }
        },
      })
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('yamlls')

      vim.lsp.config('terraformls', {
        filetypes = { "hcl", "terraform", "tf" },
      })
      vim.lsp.enable('terraformls')
      vim.lsp.enable('ols')

      vim.filetype.add({
        extension = {
          jinja = "jinja",
          jinja2 = "jinja",
          j2 = "jinja",
          html = "jinja",
        },
      })
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "[d", function()
        trouble.next({ skip_groups = true, jump = true })
      end, opts)
      vim.keymap.set("n", "]d", function()
        trouble.previous({ skip_groups = true, jump = true })
      end, opts)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

      local tele_trouble = require("trouble.sources.telescope")
      local tele = require("telescope")
      tele.setup({
        defaults = {
          mappings = {
            i = { ["<c-t>"] = tele_trouble.open },
            n = { ["<c-t>"] = tele_trouble.open },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap = true, silent = true, buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", telescope.lsp_definitions, bufopts)
          vim.keymap.set("n", "gr", telescope.lsp_references, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", telescope.lsp_implementations, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>ww", vim.diagnostic.open_float, bufopts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<leader>D", telescope.lsp_type_definitions, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set({ "v", "n" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)
        end,
      })
    end,
  },
}
