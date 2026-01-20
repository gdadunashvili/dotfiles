return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local telescope = require('telescope')
        local lga_actions = require("telescope-live-grep-args.actions")
        telescope.setup({
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = {         -- extend mappings
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
                cache_picker = { num_pickers = 10 },
                dynamic_preview_title = true,
                -- path_display = {"smart", shorten = {len = 3}},
                wrap_results = true,
                layout_strategy = 'flex',
                layout_config = {
                    width = 0.99,
                    height = 0.98,
                    horizontal = {
                        mirror = false,
                        preview_width = 0.75, -- Preview width as a percentage of the Telescope window width
                    },
                }
            },
        })

        telescope.load_extension("live_grep_args")
        local builtin = require('telescope.builtin')


        vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
        vim.cmd("autocmd User TelescopePreviewerLoaded setlocal cursorline")

        local grep_func = telescope.extensions.live_grep_args.live_grep_args
        local function custome_grep()
            local folder = vim.fn.input("Serarch Folder Path: ", vim.fn.expand('%:p:h'))
            grep_func({
                search_dirs = { folder },
            })
        end

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })

        -- command pallete
        vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })

        vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = '[F]ind [M]arks' })
        vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = '[F]ind [J]jumps' })
        vim.keymap.set('n', '<leader><leader>', builtin.commands, { desc = '[F]ind [S]elect Telescope' })
        vim.keymap.set('n', '<c-p>', builtin.commands, { desc = '[F]ind [S]elect Telescope' })

        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
        vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })

        vim.keymap.set('n', '<leader>fg', grep_func, { desc = '[F]ind [G]rep' })
        vim.keymap.set('n', '<leader>gg', custome_grep, { desc = '[G]o to subfolder and [G]rep' })
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })



        vim.keymap.set('n', '<leader>f/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end,
            { desc = '[f]ind [/] in Open Files' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>fn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[F]ind [N]eovim files' })
    end
}
