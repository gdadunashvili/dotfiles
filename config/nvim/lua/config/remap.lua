vim.g.mapleader = " "
-- my awesome remaps
vim.keymap.set("n", "<C-f>", ":<C-f>")

-- the usual stuff you find on the internet
vim.keymap.set("n", "<leader>w", "<C-w>")
-- dont delete paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({ "x", "v" }, "<leader>d", "\"_dd")
vim.keymap.set("n", "<leader>dd", "\"_d")

-- copy to main clipboard
vim.keymap.set({ "v", "n", "x" }, "<C-S-c>", "\"+p")
vim.keymap.set({ "n", "v" }, "<leader>x", "\"+x")
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")

-- paste from main clipboard using cmd v
vim.keymap.set("n", "<C-S-v>", "\"+p")
vim.keymap.set("n", "<leader>Y", "\"+yg$")

-- self explanatory
vim.keymap.set("i", "jj", "<esc>", { noremap = true })
vim.keymap.set("i", "jk", "<esc>", { noremap = true })

-- Move rows instead of lines for wrapped lines
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
vim.keymap.set("n", "gj", "j", { noremap = true })
vim.keymap.set("n", "gk", "k", { noremap = true })

-- quit current window/buffer
vim.keymap.set("n", "<leader>q", ":quit<CR>", { noremap = true })
vim.keymap.set("n", "qq", ":bd<CR>", { noremap = true })

-- updating file
-- Save the file with ctrl+s needs terminal alias or it will freeze
-- according to the default behaviour of ctrl+s / ctrl+q in a terminal
-- alias nvim="stty stop '' -ixoff ; nvim"
vim.keymap.set("n", "<C-S>", ":update<CR>", { noremap = true })
vim.keymap.set("v", "<C-S>", "<C-C>:update<CR>", { noremap = true })
vim.keymap.set("i", "<C-S>", "<C-O>:update<CR>", { noremap = true })

-- tabs
vim.keymap.set("n", "<leader>p", "<esc>:tabprevious<CR>")
vim.keymap.set("n", "<leader>n", "<esc>:tabnext<CR>")
vim.keymap.set("n", "<leader>t", "<esc>:tabnew<CR>")

-- @enum 'kitty'|'tmux'
WINDOW_MANAGER = 'kitty'
-- pane navigation
local function go_vim_or_tmux_or_kitty(vim_dir, tmux_dir, kitty_dir)
    return function()
        local current_win = vim.fn.winnr()
        -- Try to move down
        vim.cmd("wincmd " .. vim_dir)
        local new_win = vim.fn.winnr()
        -- If we're in the same window, there was no split below.
        if current_win == new_win then
            if WINDOW_MANAGER == 'tmux' then
                -- Fallback: call tmux to select the pane below
                vim.fn.system("tmux select-pane -" .. tmux_dir)
            elseif WINDOW_MANAGER == 'kitty' then
                local command = "kitten @ focus-window --match neighbor:" .. kitty_dir
                vim.fn.system(command)
            end
        end
    end
end

vim.keymap.set({ "n", "i", "v" }, "<C-h>", go_vim_or_tmux_or_kitty("h", "L", "left"))
vim.keymap.set({ "n", "i", "v" }, "<C-l>", go_vim_or_tmux_or_kitty("l", "R", "right"))
vim.keymap.set({ "n", "i", "v" }, "<C-j>", go_vim_or_tmux_or_kitty("j", "D", "bottom"))
vim.keymap.set({ "n", "i", "v" }, "<C-k>", go_vim_or_tmux_or_kitty("k", "U", "top"))


---@param code string
local function execute_lua_code(code)
    local func, err = load(code)
    if not func then
        vim.notify("Provided text is not valid Lua code: " .. err)
        return
    end
    local ok, result = pcall(func)
    if not ok then
        vim.notify("Runtime error: " .. err)
    else
        if result ~= nil then
            vim.inspect(result)
        end
    end
end

-- Function to execute the current line as Lua code
local function exec_line_as_lua()
    local line = vim.api.nvim_get_current_line() -- Get the current line under the cursor
    execute_lua_code(line)
end

local function exec_selection_as_lua()
    local selection = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"))
    local result = table.concat(selection, "\n")
    execute_lua_code(result)
end

vim.api.nvim_create_user_command('ExecLineAsLua', exec_line_as_lua, {})
vim.api.nvim_create_user_command('ExecSelectionAsLua', exec_selection_as_lua, {})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("LueLocalFunctionality", { clear = false }),
    pattern = "*.lua",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>e", "<cmd>ExecLineAsLua<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "v", "<localleader>e", ":ExecSelectionAsLua<CR>",
            { noremap = true, silent = true })
    end
})
