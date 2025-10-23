return {
    'MeanderingProgrammer/render-markdown.nvim',
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        file_types = { 'markdown', 'Avante' },
        log_level = 'debug',
        overrides = {
            buftype = {
                nofile = {
                    render_modes = { 'n', 'c', 'i' },
                    debounce = 5,
                },
            },
            filetype = {},
        },
    },
    ft = { 'markdown', 'Avante' },
}
