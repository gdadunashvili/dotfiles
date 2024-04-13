vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>/", ":TComment<CR>j")
vim.keymap.set("i", "<leader>/", "<esc>:TComment<CR>j")
vim.keymap.set("v", "<leader>/", ":TComment<CR>j")

-- cpp reference map
vim.keymap.set("n", "<C-c>", ":!open 'https://en.cppreference.com/mwiki/index.php?search=<C-R><C-W>'<CR>")


-- dont delete paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

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

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
