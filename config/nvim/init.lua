require("config.lazy")
require("lazy").setup("plugins")

require("config")
pcall(require("local/init"))
