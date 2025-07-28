
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

    local bg_hl = vim.api.nvim_get_hl(0, {name="Normal"})
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
    update_cursor()
end
local function dark_f()
    vim.o.background = "dark"
    common_mode()
end


local function light_f()
    vim.o.background = "light"
    common_mode()
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


local function setupTimer()
    local timer = vim.uv.new_timer()
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
        setupTimer()
    end
}

