vim.opt.cursorline = true
vim.g.python_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3'

local create_dir_if_not_exists = function(dir)
    local ldir = vim.fn.expand(dir)
    local test = vim.fn.isdirectory(ldir)
    if not test then
        vim.fn.mkdir(dir, "p")
    end
end

-- check if .nvimsessions exists
create_dir_if_not_exists(vim.fn.expand("~/.nvimsessions"))

-- Use relativenumbers to use commands for multiple lines way faster
-- For the current line print the absolute linenumber instead of a
-- useless 0 --]]
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wrap = false

-- only one global statusbar
-- vim.opt.laststatus = 3
-- every window has it's own statusbar
vim.opt.laststatus = 2

-- no swap files
vim.opt.swapfile = false
vim.opt.backup = false

-- undo
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/tmp"
vim.opt.undofile = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000


vim.keymap.set("n", "U", "<C-r>", { noremap = true })

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true
-- tab settings
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- wrap
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120
vim.opt.showbreak = "↳  "
-- vim.opt_local.formatoptions:remove('t') -- don't auto wrap text when typing
vim.opt.wrap = false

local text_wrap_group_id = vim.api.nvim_create_augroup("text_wrap", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.tex", "*.txt", '*.md', '*.trlc' },
    group = text_wrap_group_id,
    callback = function(_)
        vim.opt.wrap = true
    end
})

-- timeouts
-- No timeout by default
vim.cmd("set notimeout")

-- set different timeouts for normal and insert mode
vim.api.nvim_create_augroup("NoTimeoutNormalMode", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
    group = "NoTimeoutNormalMode",
    command = "set timeout timeoutlen=200",
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = "NoTimeoutNormalMode",
    command = "set notimeout",
})

-- Make tab completion for files/buffers act like bash
vim.o.wildmode = "full"
vim.o.wildmenu = true


vim.o.autoread = true


-- autoformatting
-- the following code autoformats files on save. It looks more complex than it should because it handles the edge cases:
--  - excluded types. Unwanted filetype can be added the excluded_filetypes table
--  - if a language is injected inside a buffer of a given filetype then
--    it the injected language will not be formatted by the formatting rules of the outer buffer language.

-- Define filetypes to exclude from format-on-save
local excluded_filetypes = {
    "trlc",
}

local function escape_lua_pattern(text)
    return text:gsub("(%W)", "%%%1")
end

local function get_line_comment_prefix(bufnr)
    local cs = vim.bo[bufnr].commentstring
    if not cs or cs == "" then
        return nil
    end

    -- commentstring usually looks like "// %s" or "-- %s"
    local prefix = cs:match("^(.*)%%s")
    if not prefix then
        return nil
    end

    prefix = vim.trim(prefix)
    if prefix == "" then
        return nil
    end

    return escape_lua_pattern(prefix)
end

local function has_stop_format_markers(bufnr)
    local prefix = get_line_comment_prefix(bufnr)
    if not prefix then
        return false
    end

    local exclusion_pattern = "^%s*" .. prefix .. "%s*TurnOffFormatOnSave"

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local in_block = false
    for _, line in ipairs(lines) do
        if line:find(exclusion_pattern) then
            return true
        end
    end
    return in_block
end

local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if vim.tbl_contains(excluded_filetypes, ft) then
            return
        end

        if has_stop_format_markers(args.buf) then
            return
        end

        vim.lsp.buf.format()
    end,
})
