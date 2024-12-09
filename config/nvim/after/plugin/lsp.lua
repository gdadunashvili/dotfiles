-- require('cobol.nvim').setup {}

local lsp = require('lsp-zero').preset({})


LSP_HOVER_OR_MAN = function()
    -- Check if hover capability exists and is supported
    if vim.lsp.capabilities.hoverProvider then --buf.capabilities.hoverProvider then
        vim.lsp.buf.hover()
    else
        vim.cmd("normal! K")
    end
end


lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}
  lsp.default_keymaps({buffer = bufnr})
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gi", '<CMD>Glance implementations<CR>', opts)
  -- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "gr", '<CMD>Glance references<CR>', opts)
  vim.keymap.set("n", "gw", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "af", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<F1>", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<F2>", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<F6>", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

local cmp = require('cmp')

local next_choice = function (fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

local prev_choice = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `ultisnips` user.
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- ['<Tab>'] = next_choice,
        -- ['<S-Tab>'] = prev_choice,
        ['<C-j>'] = next_choice,
        ['<C-k>'] = prev_choice ,
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Esc>'] = cmp.mapping.close(),
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = {
        { name = 'nvim_lsp' }, -- For nvim-lsp
        { name = 'ultisnips' }, -- For ultisnips user.
        { name = 'nvim_lua' }, -- for nvim lua function
        { name = 'path' }, -- for path completion
        { name = 'buffer', keyword_length = 4 }, -- for buffer word completion
        { name = 'omni' },
        { name = 'emoji', insert = true, } -- emoji completion
    },
    completion = {
        keyword_length = 1,
        completeopt = "menu,noselect"
    },
    view = {
        entries = 'custom',
    },
})


local capabilities = {
  textDocument = {
    completion = {
      editsNearCursor = true,
    },
  },
  offsetEncoding =  { 'utrf-8', 'utf-16'},
  }
  --require('cmp_nvim_lsp').default_capabilities()

local lspconfig =  require('lspconfig')

lspconfig.clangd.setup {
    capabilities = capabilities,
    -- cmd = { 'clangd', '--std=c23' },
}

-- local nvim_lsp = require('lspconfig')
-- nvim_lsp.clangd.setup {
--   filetypes = { 'c', 'cpp' },
--   cmd = { 'clangd', '--std=c23' },
--   root_dir = nvim_lsp.util.root_pattern('.git', 'compile_commands.json'),
-- }

lspconfig.julials.setup {
    capabilities = capabilities,
}
lsp.setup()

lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = lsp.on_attach,
    cmd = {
      'rustup', 'run', 'stable', 'rust-analyzer',
    },
}

-- lspconfig.jedi_language_server.setup {
--     capabilities = capabilities,
--     on_attach = lsp.on_attach,
--     settings = {
--         jedi = {
--           environment = '/opt/homebrew/bin/python3.12',
--             },
--         },
-- }

-- lspconfig.pylsp.setup{
--   cmd = { 'pylsp', '-v', '--interpreter', '/opt/homebrew/bin/python3.12' },
--   settings = {
--     pylsp = {
--       plugins = {
--         mypy = {
--           enabled = false,
--         },
--         pycodestyle = {
--           enabled = true,
--         },
--       }
--     }
--   }
-- }
