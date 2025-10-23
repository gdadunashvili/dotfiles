local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 30
local MIN_LABEL_WIDTH = 30

-- plugin for completeions
return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-emoji",
        "onsails/lspkind.nvim",
    },


    config = function()
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
                    vim.snippet.expand(args.body)
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
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'path' },
                { name = 'buffer',  keyword_length = 4 },
                { name = 'omni' },
                { name = 'emoji',   insert = true, }
            },
            completion = {
                keyword_length = 1,
                completeopt = "menu",
                border = "single",
                winhighlight = "Normal:CmpNormal",
            },
            window = {
                completion = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Custom border
                    winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder,Search:None',
                    winblend = 0, -- Transparency level (0 = opaque)
                    zindex = 1001, -- Window stacking priority
                    scrolloff = 2, -- Lines above/below selection
                    col_offset = -3, -- Horizontal position adjustment
                    side_padding = 1, -- Padding inside the window
                    scrollbar = true, -- Show scrollbar for many items
                    max_width = 80, -- Maximum width
                },
                documentation = {
                    border = 'rounded', -- Rounded borders
                    winhighlight = 'FloatBorder:CmpDocBorder,NormalFloat:CmpDocNormal',
                    winblend = 10,      -- Slight transparency
                    zindex = 1000,      -- Higher than completion window
                    -- max_height = 20,    -- Maximum height
                    -- max_width = 80,     -- Maximum width
                },
            },
            formatting = {
                format = function(entry, vim_item)
                    vim_item = require('lspkind').cmp_format()(entry, vim_item)
                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
                    if truncated_label ~= label then
                        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                    elseif string.len(label) < MIN_LABEL_WIDTH then
                        local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                        vim_item.abbr = label .. padding
                    end
                    return vim_item
                end,
            },
            view = {
                entries = 'custom',
                selection_order = 'near_cursor',

                docs = {
                    auto_open = true, -- Auto-show docs for selected item
                }
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
    end
}
