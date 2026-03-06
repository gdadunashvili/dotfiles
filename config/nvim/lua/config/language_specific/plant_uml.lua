--------------------------------------------------------------------------------
--------------------------------- Markdown -------------------------------------
--------------------------------------------------------------------------------


vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("PumlStuff", { clear = false }),
    pattern = { "*.puml" },
    callback = function()
        vim.notify("entering puml")
        local lspconfig = require('lspconfig')
        local configs = require("lspconfig.configs")
        if not configs.plantuml_lsp then
            configs.plantuml_lsp = {
                default_config = {
                    cmd = {
                        -- "/path/to/plantuml-lsp",
                        -- "--stdlib-path=/path/to/plantuml-stdlib",

                        --
                        -- FOR DIAGNOSTICS (choose up to one of 'jar-path' and 'exec-path' flags):
                        --
                        -- Running plantuml via a .jar file:
                        -- "--jar-path=/home/linuxbrew/.linuxbrew/Cellar/plantuml/1.2025.3/libexec/plantuml.jar",
                        -- With plantuml executable and available from your PATH there is a simpler method:
                        "--exec-path=/home/linuxbrew/.linuxbrew/bin/plantuml",
                    },
                    filetypes = { "plantuml" },
                    root_dir = function(fname)
                        return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
                    end,
                    settings = {},
                }
            }
        end
        lspconfig.plantuml_lsp.setup {}
        vim.lsp.config('plantuml_lsp', { config = configs.plantuml_lsp })
    end
})
