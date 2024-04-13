vim.g.slime_target = "tmux"
vim.g.slime_target = 'kitty'

-- NOTE: Assumes that kitty.conf has parameter 
-- 'listen_on' set to unix:/tmp/mykitty
-- In this case, kitty will append the pid of kitty to the end of the path
-- Thus we check the pid of the kitty instance, and use that as the 
--
-- local pid = vim.fn.system("pgrep kitty")
-- pid = pid:gsub("[\n\r]","")
-- local listen_on = string.format("unix:/tmp/mykitty-%s", pid)
vim.g.slime_default_config = {['listen_on']="unix:/tmp/mykitty", ['window_id']=1}

-- vim.g.slime_default_config = {"sessionname","jl", "windowname", "1"}
vim.g.slime_dont_ask_default = 1
vim.g.slime_cell_delimiter = "#\\s*%%"
vim.keymap.set("n", "<leader>a", "<Plug>SlimeSendCell")
vim.keymap.set("v", "<leader>ar", "<Plug>SlimeRegionSend")
-- vim.keymap.set("x", "<leader>ar", "<Plug>SlimeRegionSend")
