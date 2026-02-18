-- return {
--	"junegunn/fzf.vim",
--	dependencies = { "junegunn/fzf", build = "./install --all" },
-- }
return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "nvim-mini/mini.icons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {
		winopts = {
			preview = { layout = "vertical", size = "down:50%" },
		},
		keymap = {
			fzf = {
				["ctrl-j"] = "down",
				["ctrl-k"] = "up",
			},
		},
	},
	---@diagnostic enable: missing-fields
}
