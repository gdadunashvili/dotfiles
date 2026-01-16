local function darken_color(color, amount)
    local r = tonumber(color:sub(2, 3), 16)
    local g = tonumber(color:sub(4, 5), 16)
    local b = tonumber(color:sub(6, 7), 16)

    r = math.max(0, r - amount)
    g = math.max(0, g - amount)
    b = math.max(0, b - amount)

    return string.format("#%02x%02x%02x", r, g, b)
end

local function update_cursor()
    local bg_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    local bg_color = nil
    if bg_hl ~= nil then
        if bg_hl.bg ~= nil then
            bg_color = bg_hl.bg
        end
    end
    if bg_color ~= nil then
        local bg_hex = string.format("#%06x", bg_color)
        local darker_bg = darken_color(bg_hex, 60)
        vim.api.nvim_set_hl(0, "CursorLine", { bg = darker_bg })
    end
end

local function common_mode()
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#8B0089", ctermfg = 245 })
    -- update_cursor()
end

local function dark_f(_, dark_name)
    vim.cmd.colorscheme(dark_name)
    vim.o.background = "dark"
end


local function light_f(light_name, _)
    vim.cmd.colorscheme(light_name)
    vim.o.background = "light"
end

local function is_dark()
    local path = os.getenv("HOME") .. "/.is_dark"
    local file = io.open(path, "r")
    if file ~= nil then
        file:close()
        return true
    end
    return false
end


local old_is_dark = is_dark()

local function mode()
    local new_is_dark = is_dark()
    if new_is_dark == old_is_dark then return end

    old_is_dark = new_is_dark

    if new_is_dark then
        return dark_f
    else
        return light_f
    end
end


local function setupTimer(light_name, dark_name)
    local timer = vim.uv.new_timer()
    timer:start(0, 5000, vim.schedule_wrap(function()
        local callable_opt = mode()
        if callable_opt ~= nil then
            callable_opt(light_name, dark_name)
        end
    end
    ))
end


return {
    'ferdinandrau/carbide.nvim',
    priority = 1000,
    dependencies = {
        {
            { 'nickkadutskyi/jb.nvim', name = 'jb' },
            'norcalli/nvim-colorizer.lua',
        },
    },
    config = function()
        require('carbide').setup({
            style = {
                keywords = { bold = true },
                strings = { italic = true },
            },
            palette_overrides = {
                dark = {
                },
            },
            plugins = {
                ["gitsigns.nvim"] = true,
            },
            scheme_overrides = function(colors, variant, style)
                return {
                    GitSignsChangeLnInline = { bg = colors.bgc_yellow },
                    GitSignsAddLnInline = { bg = colors.bgc_green },
                    GitSignsDeleteLnInline = { bg = colors.bgc_red },
                    GitSignsCurrentLineBlame = { fg = "#8B0089" },
                    Macro = { fg = colors.fgc_yellow },
                    ["@constant.macro"] = { link = "Macro" },
                    ['@variable.member'] = { link = "Constant" },
                }
            end,
        })

        vim.cmd.colorscheme("carbide")
    end
}
