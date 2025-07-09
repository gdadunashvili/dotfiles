local function get_if_dark()
    return (vim.o.background == 'dark')
end

return {
    'https://gitlab.com/itaranto/plantuml.nvim',
    version = '*',
    config = function()
        require('plantuml').setup({
            renderer = {
                type = 'image',
                options = {
                    -- split_command="vsplit",
                    -- prog = 'feh',
                    dark_mode = get_if_dark(),
                    format = 'png', -- Allowed values: nil, 'png', 'svg'.
                }
            },
            render_on_write = true,
        }
    )
end,
}
