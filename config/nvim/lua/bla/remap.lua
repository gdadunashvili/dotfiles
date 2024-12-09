vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>/", ":TComment<CR>j")
vim.keymap.set("i", "<leader>/", "<esc>:TComment<CR>j")
vim.keymap.set("v", "<leader>/", ":TComment<CR>j")

vim.keymap.set("n", "<leader>w", "<C-w>")
-- dont delete paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")


vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.tmux-sessionizer<CR>")
-- copy to main clipboard 

vim.keymap.set("v", "<cmd-c>", "\"+p")
vim.keymap.set("n", "<cmd-c>", "\"+p")
vim.keymap.set("x", "<cmd-c>", "\"+p")

vim.keymap.set("n", "<leader>x", "\"+x")
vim.keymap.set("v", "<leader>x", "\"+x")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- paste from main clipboard using cmd v
vim.keymap.set("n", "<cmd-v>", "\"+p")

vim.keymap.set("n", "<leader>Y", "\"+yg$")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true

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

-- nnoremap U <C-r>


vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
-- tab settings
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

-- wrap
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
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
