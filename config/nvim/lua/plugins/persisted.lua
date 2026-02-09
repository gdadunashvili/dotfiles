return {
    "olimorris/persisted.nvim",
    lazy = false,

    config = function(_, opts)
        local persisted = require("persisted")
        persisted.branch = function()
            local branch = vim.fn.systemlist("git branch --show-current")[1]
            return vim.v.shell_error == 0 and branch or nil
        end

        vim.api.nvim_create_autocmd("VimEnter", {
            nested = true,
            callback = function()
                persisted.autoload({ force = true })
            end,
        })

        opts = {
            autoload = true,
            on_autoload_no_session = function()
                vim.notify("No existing session to load.")
            end,

            autosave = true,
            use_git_branch = true,
            telescope = {
                mappings = { -- Mappings for managing sessions in Telescope
                    copy_session = "<C-c>",
                    change_branch = "<C-b>",
                    delete_session = "<C-d>",
                },
                icons = { -- icons displayed in the Telescope picker
                    selected = " ",
                    dir = "  ",
                    branch = " ",
                },
            },
        }
        persisted.setup(opts)
    end
}
