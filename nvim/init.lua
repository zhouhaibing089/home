for name in pairs(package.loaded) do
	if name:match("^config%.") then
		package.loaded[name] = nil
	end
end

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.neotree")
require("config.fzf")
require("config.toggleterm")
require("config.lsp")
require("config.treesitter")
require("config.colors")
require("config.aerial")
require("config.conform")
require("config.zen")
