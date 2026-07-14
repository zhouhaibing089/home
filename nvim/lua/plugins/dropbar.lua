return {
	{
		"Bekaboo/dropbar.nvim",
		config = function()
			local sources = require("dropbar.sources")
			local bar_enable = require("dropbar.configs").opts.bar.enable
			local path_relative_to = require("dropbar.configs").opts.sources.path.relative_to

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
						relative_to = function(buf, win)
							-- use default when not file or directory
							if vim.bo[buf].buftype ~= "" then
								return path_relative_to(buf, win)
							end
							local name = vim.api.nvim_buf_get_name(buf)
							-- iterate through window local and tab local cwd
							for _, cwd in ipairs({ vim.w.cwd, vim.t.cwd }) do
								if cwd then
									-- if name starts with cwd
									local root = vim.fs.abspath(cwd)
									if name:sub(1, #root) == root then
										return root
									end
								end
							end
							return vim.fn.getcwd()
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
