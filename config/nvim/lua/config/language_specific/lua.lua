--------------------------------------------------------------------------------
---------------------------------    Lua   -------------------------------------
--------------------------------------------------------------------------------

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
