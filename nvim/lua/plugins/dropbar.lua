return {
	{
		"Bekaboo/dropbar.nvim",
		config = function()
			local sources = require("dropbar.sources")
			local bar_enable = require("dropbar.configs").opts.bar.enable

			require("dropbar").setup({
				bar = {
					enable = function(buf, win, info)
						-- I still want to have winbar for floating toggleterm
						if vim.bo[buf].filetype == "toggleterm" then
							return true
						end
						-- I want this to be enabled for any file buffers
						if vim.api.nvim_buf_get_name(buf) ~= "" and vim.bo[buf].buftype == "" then
							return true
						end
						return bar_enable(buf, win, info)
					end,
					sources = function(_, _)
						return {
							-- make path sources un-clickable:
							-- {
							-- 	name = "path",
							-- 	get_symbols = function(buf, win, cursor)
							-- 		local symbols = sources.path.get_symbols(buf, win, cursor)
							-- 		for _, symbol in ipairs(symbols) do
							-- 			symbol.on_click = false
							-- 		end
							-- 		return symbols
							-- 	end,
							-- },
							sources.path,
							sources.lsp,
						}
					end,
				},
				sources = {
					path = {
						relative_to = function(_, _)
							if vim.w.cwd then
								return vim.fs.abspath(vim.w.cwd)
							elseif vim.t.cwd then
								return vim.fs.abspath(vim.t.cwd)
							else
								return vim.fn.getcwd()
							end
						end,
						modified = function(sym)
							sym.name = sym.name .. " ●"
							sym.name_hl = "DiagnosticWarn"
							return sym
						end,
					},
				},
			})
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
		end,
	},
}
