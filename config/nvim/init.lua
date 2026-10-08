require("config.lazy")
require("config.init")


local ok = pcall(function() require("local.init") end)

if ok then
    require("local.init")
else
    vim.notify("no local config")
end
