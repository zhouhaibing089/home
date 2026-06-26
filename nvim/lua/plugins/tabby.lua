return {
	"nanozuki/tabby.nvim",
	---@type TabbyConfig
	opts = {
		preset = "tab_only",
		option = {
			tab_name = {
				override = function(tabid)
					local tabnr = vim.api.nvim_tabpage_get_number(tabid)
					local cwd = vim.fn.getcwd(-1, tabnr)

					local name = vim.fn.fnamemodify(cwd, ":t")
					return name ~= "" and name or cwd
				end,
			},
		},
	},
}
