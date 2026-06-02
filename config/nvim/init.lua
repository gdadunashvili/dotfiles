require("config.lazy")
require("lazy").setup("plugins")
require("config.init")

local ok, _ = pcall(function() require("local.init") end)
if ok then
    local ok_init, _ = pcall(require "local.init")
    if ok_init then
        require("local.init")
    end
else
    vim.notify("no local config")
end
