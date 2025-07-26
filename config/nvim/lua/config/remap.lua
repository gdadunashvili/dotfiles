vim.g.mapleader = " "

vim.keymap.set("n", "<C-f>", ":<C-f>")

vim.keymap.set("n", "<leader>w", "<C-w>")
-- dont delete paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({"x", "v"}, "<leader>d", "\"_dd")
vim.keymap.set("n", "<leader>dd", "\"_d")

-- copy to main clipboard
vim.keymap.set({"v", "n", "x"}, "<C-S-c>", "\"+p")
vim.keymap.set({"n","v"}, "<leader>x", "\"+x")
vim.keymap.set({"n","v"}, "<leader>y", "\"+y")

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


