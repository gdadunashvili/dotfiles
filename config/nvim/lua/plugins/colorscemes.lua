local function set_comments()
    vim.api.nvim_set_hl(0, "BlameLineNvim", { fg = "#8B0089", ctermfg = 245 })
end

local function dark_f()
    vim.api.nvim_set_option_value('background', 'dark', {})
end

local function light_f()
    vim.api.nvim_set_option_value('background', 'light', {})
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

