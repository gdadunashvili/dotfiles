require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "julials" }, -- Automatically install clangd if not present
    automatic_installation = true, -- Automatically install LSP servers if they're required by a filetype and not installed
})

local lspconfig = require('lspconfig')

-- Configure clangd with the path to your compile_commands.json
lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--compile-commands-dir=build",
        "--background-index",
        "--suggest-missing-includes"
    },
    -- Additional configuration options can be added here
})


lspconfig.julials.setup {
  on_attach = function(client, bufnr)
    require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
  end,
}

