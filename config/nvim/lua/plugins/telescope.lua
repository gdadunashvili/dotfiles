return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-lua/plenary.nvim",
    },
    config =  function ()
        local telescope = require('telescope')
        local lga_actions = require("telescope-live-grep-args.actions")
        telescope.setup({
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = { -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            ["<C-n>"] = lga_actions.quote_prompt({ postfix = " --no-ignore " }),
                            -- freeze the current list and start a fuzzy search in the frozen list
                            ["<C-space>"] = lga_actions.to_fuzzy_refine,
                        },
                    },
                }
            },
            defaults = {
                preview = {
                    winhighlight = 'CursorLine:Visual',
                    hide_on_startup = false,
                    treesitter = true,
                },
                cache_picker = {num_pickers = 10},
                dynamic_preview_title = true,
                -- path_display = {"smart", shorten = {len = 3}},
                wrap_results = true,
                layout_strategy = 'flex',
                layout_config = {
                    width = 0.99,
                    height = 0.98,
                    horizontal = {
                        mirror = false,
                        preview_width = 0.75,  -- Preview width as a percentage of the Telescope window width
                    },
                }
            },
        })

        telescope.load_extension("live_grep_args")
        local builtin = require('telescope.builtin')


        vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
        vim.cmd("autocmd User TelescopePreviewerLoaded setlocal cursorline")
    -- telescope.extensions.live_grep_args.live_grep_args

        local grep_func = telescope.extensions.live_grep_args.live_grep_args
        local function custome_grep()
            local folder = vim.fn.input("Serarch Folder Path: ", vim.fn.getcwd())
            grep_func({
            -- builtin.live_grep({
                search_dirs={folder},
            })
        end

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', grep_func, {})
        vim.keymap.set('n', '<leader>gg', custome_grep, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fr', builtin.resume, {})
        vim.keymap.set('n', '<leader>fp', function ()
            builtin.grep_string({
                search = vim.fn.input("Grep > ")});
            end)
        end
    }
