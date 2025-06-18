vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("blaGroup", {
        clear = false
    }),
    callback = function(e)
        local opts = { buffer = e.buf, remap = false }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "gw", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "af", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "W", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<F1>", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<F2>", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        vim.keymap.set("n", "<S-F2>", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
        vim.keymap.set("n", "<F6>", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "H", function() vim.lsp.buf.signature_help() end, opts)
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
        -- autocompletion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-emoji",
        "b0o/schemastore.nvim",
        -- code docs and snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "dcampos/nvim-snippy",
        "dcampos/cmp-snippy",
        -- shows lsp errors and other lsp messages on the bottom right
        "j-hui/fidget.nvim"
    },
    config = function()
        require('fidget').setup({})
        local cmp = require('cmp')

        local next_choice = function(fallback)
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
                    -- For `ultisnips` user.j
                    require('luasnip').lsp_expand(args.body)
                    require('snippy').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-j>'] = next_choice,
                ['<C-k>'] = prev_choice,
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Esc>'] = cmp.mapping.close(),
            }),
            sources = {
                { name = 'nvim_lsp' },                   -- For nvim-lsp
                { name = 'luasnip' },                    -- For ultisnips user.
                { name = 'nvim_lua' },                   -- for nvim lua function
                { name = 'snippy' },
                { name = 'path' },                       -- for path completion
                { name = 'buffer',  keyword_length = 4 }, -- for buffer word completion
                { name = 'omni' },
                { name = 'emoji',   insert = true, }     -- emoji completion
            },
            completion = {
                keyword_length = 1,
                completeopt = "menu",
                border = "single",
                winhighlight = "Normal:CmpNormal",
            },
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            },
            view = {
                entries = 'custom',
            },
        })

        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_lsp.default_capabilities()
        -- this  helps with folding
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

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

        local lspconfig = require('lspconfig')
        local handlers = {
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup {
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
                    settings = {
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
            ensure_installed = { "lua_ls", "clangd", "bashls", "ltex", "jedi_language_server",
                "pyright", "pylsp", "jsonls" },
            automatic_installation = true,
            handlers = handlers,
        })

        vim.lsp.inlay_hint.enable()
    end
}
