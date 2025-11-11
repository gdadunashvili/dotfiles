vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("blaGroup", {
        clear = false
    }),
    ---@param e vim.api.keyset.create_autocmd.callback_args
    callback = function(e)
        local opts = { buffer = e.buf, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gw", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>af", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<A-CR>", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "W", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<F1>", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<F2>", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
        vim.keymap.set("n", "<F6>", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>o", ":LspClangdSwitchSourceHeader<CR>", opts)
        vim.keymap.set("n", "H", vim.lsp.buf.signature_help, opts)
    end
})

vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})


return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "b0o/schemastore.nvim",
        -- shows lsp errors and other lsp messages on the bottom right
        "j-hui/fidget.nvim",
        -- lsp autocompletion
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require('fidget').setup({})

        local current_folder = vim.fn.expand("%:p:h")

        local love_path = os.getenv("HOME") .. "/github_install/love2d/"

        local lua_runtime_files = {}

        if (io.open(love_path, "r") ~= nil) then
            lua_runtime_files[love_path] = true
        end

        if string.find(current_folder, "config/nvim") ~= nil then
            for _, path in ipairs(vim.api.nvim_get_runtime_file("", true)) do
                lua_runtime_files[path] = true
            end
        else
        end

        local lua_ls_settings = {
            completion = { autoRequire = true },
            Lua = {
                diagnostics = {
                    globals = { "love", "vim", "it", "describe", "before_each", "after_each" },
                },
                workspace = {
                    library = lua_runtime_files,
                },
            }
        }

        vim.lsp.config("lua_ls", { settings = lua_ls_settings })

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_lsp.default_capabilities()
        -- this  helps with folding
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        local lspconfig = require('lspconfig')

        local handlers = {
            function(server_name) -- default handler (optional)
                lspconfig[server_name].setup {
                    capabilities = capabilities,
                }
            end,

            ["jsonls"] = function()
                lspconfig.jsonls.setup {
                    settings = {
                        json = {
                            schemas = require('schemastore').json.schemas {
                                extra = {
                                    -- {
                                    --     description = 'My other custom JSON schema',
                                    --     fileMatch = { 'bar.json', '.baar.json' },
                                    --     name = 'bar.json',
                                    --     url = 'https://example.com/schema/bar.json',
                                    -- },
                                },
                            },
                            validate = { enable = true },
                        },
                    },
                }
            end,

            ["lua_ls"] = function()
                lspconfig.lua_ls.setup {
                    capabilities = capabilities,
                    settings = lua_ls_settings
                }
            end,
            ["clangd"] = function()
                lspconfig.clangd.setup({
                    capabilities = capabilities,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--suggest-missing-includes",
                        "--compile-commands-dir=build",
                        "--background-index", "-j=6",
                    },
                })
            end,

            ["ltex"] = function()
                lspconfig.ltex.setup({
                    filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
                })
            end
        }

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "clangd", "bashls", "ltex", "pylsp", "jsonls" },
            automatic_installation = true,
            handlers = handlers,
        })

        vim.lsp.inlay_hint.enable()
    end
}
