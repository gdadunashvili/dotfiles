vim.opt.cursorline = true

-- Create an autocommand group
vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd({"BufWritePre"},
{
    group = "FormatOnSave",
    pattern = { "*.cpp", "*.h", "*.hpp" },
    callback= function ()
        local current_pos = vim.fn.winsaveview()
        vim.cmd("%!clang-format")
        vim.fn.winrestview(current_pos)
    end
})

local function central_float()
    vim.notify("creating central float")


    local buf_id = vim.api.nvim_create_buf(false, true)
    local ui  = vim.api.nvim_list_uis()[1]


    local width = ui.width - 2
    local height = ui.height - 10

    local col = (ui.width/2) - (width/2)
    local row = (ui.height/2) - (height/2)
    --- @type vim.api.keyset.win_config
    local opts = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        anchor = 'NW',
        mouse = true,

    }

    local win_id = vim.api.nvim_open_win(buf_id, true, opts)
    return win_id, buf_id
end


local function central_terminal()
    central_float()
    vim.fn.execute("edit term://zsh")
end

vim.keymap.set("n", "<leader>\\", central_terminal, {} )

-- Use relativenumbers to use commands for multiple lines way faster
-- For the current line print the absolute linenumber instead of a
-- useless 0 --]]
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.wrap = false

-- only one global statusbar
vim.opt.laststatus = 3

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

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.tex", "*.txt", '*.md'},
  group = text_wrap_group_id,
  callback = function(_)
    vim.opt.wrap = true
  end
})

-- set different timeouts for normal and insert mode
vim.api.nvim_create_augroup("NoTimeoutNormalMode", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = "NoTimeoutNormalMode",
  command = "set timeout",
})
-- this timeoutlen wil only apply to insert mode i.e. mainly just jj and jk
vim.opt.timeoutlen = 200

vim.api.nvim_create_autocmd("InsertLeave", {
  group = "NoTimeoutNormalMode",
  command = "set notimeout",
})


-- Make tab completion for files/buffers act like bash
vim.o.wildmode = "full"
vim.o.wildmenu = true


vim.o.autoread = true

--[[
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
--]]

