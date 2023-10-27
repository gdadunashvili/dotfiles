local lsp = require('lsp-zero').preset({})

LSP_HOVER_OR_MAN = function()
    -- Check if hover capability exists and is supported
    if vim.lsp.buf.capabilities.hoverProvider then
        vim.lsp.buf.hover()
    else
        vim.cmd("normal! K")
    end
end


lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
  vim.keymap.set("n", "gd", LSP_HOVER_OR_MAN)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end )
  -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
  -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end)
  vim.keymap.set("n", "<F2>", function() vim.diagnostic.goto_next() end)
  vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.goto_prev() end)
  -- vim.keymap.set("n", "<leader>nca", function() vim.lsp.buf.code_action() end)
  -- vim.keymap.set("n", "<leader>nrr", function() vim.lsp.buf.references() end)
  vim.keymap.set("n", "<F6>", function() vim.lsp.buf.rename() end)
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
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
 
    -- formatting = {
        -- format = lspkind.cmp_format({
            -- mode = "symbol_text",
            -- menu = ({
                -- nvim_lsp = "[LSP]",
                -- ultisnips = "[US]",
                -- nvim_lua = "[Lua]",
                -- path = "[Path]",
                -- buffer = "[Buffer]",
                -- emoji = "[Emoji]",
                -- omni = "[Omni]",
            -- }),
        -- }),
    -- },
})
 
-- lsp.setup_nvim_cmp({
  -- mapping = cmp_mappings
-- })

lsp.setup()
