
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
    local bg_color = vim.api.nvim_get_hl_by_name("Normal", true).background
    local bg_hex = string.format("#%06x", bg_color)
    local darker_bg = darken_color(bg_hex, 60)
    vim.api.nvim_set_hl(0, "CursorLine", { bg = darker_bg })
end

local function set_comments()
    vim.api.nvim_set_hl(0, "BlameLineNvim", { fg = "#8B0089", ctermfg = 245 })
end

local function dark_f()
    vim.api.nvim_set_option_value('background', 'dark', {})
    update_cursor()
end

local function light_f()
    vim.api.nvim_set_option_value('background', 'light', {})
    update_cursor()
end

local function is_dark()
    local path = os.getenv("HOME").."/.is_dark"
    local file = io.open(path, "r")
    if file~=nil then
        file:close()
        return true
    end
    return false
end

local function mode()
    if is_dark() then
        return dark_f
    else
        return light_f
    end
end

-- mode()()

local function setupTimer()
    local timer = vim.loop.new_timer()
    timer:start(0, 3000, vim.schedule_wrap(function ()
        mode()()
    end
    ))
end


return {
    'nickkadutskyi/jb.nvim',
    name = 'jb',
    config = function ()
        vim.cmd('colorscheme jb')
        set_comments()
        setupTimer()
    end
}

