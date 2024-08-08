local cmp = require('cmp')
local cmp_lsp = require("cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities()
  )

local lspconfig = require("lspconfig")
require("fidget").setup({})
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "clangd",
    "julials",
    "rust_analyzer",
    "gopls",
  },
  automatic_installation = true, -- Automatically install LSP servers if they're required by a filetype and not installed
  handlers = {
    function(server_name) -- default handler (optional)

      require("lspconfig")[server_name].setup {
        capabilities = capabilities
      }
    end,

    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "it", "describe", "before_each", "after_each" },
            }
          }
        }
      }
    end,
    ["clangd"] = function ()
      lspconfig.clangd.setup({
        on_attach = function (client, bufnr)
          client.server_capabilities.signatureHelpProvider = false
          lspconfig.on_attach(client, bufnr)
          require('virtualtypes').on_attach()
        end,
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--compile-commands-dir=build",
          "--background-index",
          "--suggest-missing-includes"
        },
      })
      end,

      ["julials"]= function ()
        lspconfig.julials.setup {
          on_attach = function(client, bufnr)
          cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
          lspconfig.on_attach(client, bufnr)
          end,
        }
      end,
  }
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Tab>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

vim.diagnostic.config({
  -- update_in_insert = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})




-- require("mason").setup()
-- require("mason-lspconfig").setup({
--     ensure_installed = { "clangd", "julials" }, -- Automatically install clangd if not present
--     automatic_installation = true, -- Automatically install LSP servers if they're required by a filetype and not installed
-- })

-- local lspconfig = require('lspconfig')

-- Configure clangd with the path to your compile_commands.json
-- lspconfig.clangd.setup({
--     cmd = {
--         "clangd",
--         "--compile-commands-dir=build",
--         "--background-index",
--         "--suggest-missing-includes"
--     },
--     -- Additional configuration options can be added here
-- })
--

-- lspconfig.julials.setup {
--   on_attach = function(client, bufnr)
--     require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
--   end,
-- }

