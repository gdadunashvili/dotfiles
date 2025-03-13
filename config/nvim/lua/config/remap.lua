vim.g.mapleader = " "

vim.keymap.set("n", "<leader>/", ":TComment<CR>j")
vim.keymap.set("i", "<leader>/", "<esc>:TComment<CR>j")
vim.keymap.set("v", "<leader>/", ":TComment<CR>j")

vim.keymap.set("n", "<leader>w", "<C-w>")
-- dont delete paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({"x", "v"}, "<leader>d", "\"_dd")
vim.keymap.set("n", "<leader>dd", "\"_dd")

-- copy to main clipboard 
vim.keymap.set({"v", "n", "x"}, "<C-S-c>", "\"+p")
vim.keymap.set({"n","v"}, "<leader>x", "\"+x")
vim.keymap.set({"n","v"}, "<leader>y", "\"+y")

-- paste from main clipboard using cmd v
vim.keymap.set("n", "<C-S-v>", "\"+p")
vim.keymap.set("n", "<leader>Y", "\"+yg$")


-- pane navigation
local function go_vim_or_tmux(vim_dir, tmux_dir)
  return function ()
    local current_win = vim.fn.winnr()
    -- Try to move down
    vim.cmd("wincmd "..vim_dir)
    local new_win = vim.fn.winnr()
    -- If we're in the same window, there was no split below.
    if current_win == new_win then
      -- Fallback: call tmux to select the pane below
      vim.fn.system("tmux select-pane -"..tmux_dir)
    end
  end
end

vim.keymap.set({"n", "i", "v"}, "<C-h>", go_vim_or_tmux("h", "L"))
vim.keymap.set({"n", "i", "v"}, "<C-l>", go_vim_or_tmux("l", "R"))
vim.keymap.set({"n", "i", "v"}, "<C-j>", go_vim_or_tmux("j", "D"))
vim.keymap.set({"n", "i", "v"}, "<C-k>", go_vim_or_tmux("k", "U"))

vim.opt.nu = true
vim.opt.relativenumber = true
-- vim.opt.smartindent = true

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
