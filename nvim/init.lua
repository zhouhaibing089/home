vim.cmd("syntax on")
vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mmp = 2000

-- disable all neovide animations
vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00
-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

require("config.lazy")

-- neo-tree
vim.keymap.set("n", "<leader>nt", ":Neotree source=filesystem toggle<CR>")
vim.keymap.set("n", "<leader>nr", ":Neotree source=filesystem reveal<CR>")
vim.api.nvim_create_autocmd("User", {
	pattern = "NeoTreeRootChanged",
	callback = function(args)
		vim.cmd("cd " .. args.data.path)
	end,
})

-- fzf
local function get_visual_selection()
	-- visual mode with selection that in the same line
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local region = vim.fn.getregion(start_pos, end_pos, {
		type = vim.fn.visualmode(),
	})
	return region[1]
end

local function find_files(opts, dir)
	local query = nil
	if opts.range == 2 and opts.line1 == opts.line2 then
		query = "'" .. get_visual_selection()
	elseif #opts.fargs > 0 then
		query = opts.args
	else
		query = ""
	end
	local preview = vim.fn["fzf#vim#with_preview"]({
		options = { "--query", query },
	})
	vim.fn["fzf#vim#files"](dir, preview)
end

vim.api.nvim_create_user_command("Ff", function(opts)
	find_files(opts, vim.fn.expand("."))
end, { desc = "find files", nargs = "*", range = true })
vim.api.nvim_create_user_command("FF", function(opts)
	find_files(opts, vim.fn.expand("%:p:.:h"))
end, { desc = "find files", nargs = "*", range = true })

local function grep_files(opts, dir)
	local query = ""
	local copts = "" -- additional command options
	if opts.range == 2 and opts.line1 == opts.line2 then
		-- query from visual selection
		query = get_visual_selection()
		copts = copts .. " -F "
	end
	local i, j = opts.args:find(" --", 1, true)
	local g = ""
	if i then
		-- anything before `--` is glob filter
		for _, v in ipairs(opts.fargs) do
			if v == "--" then
				break
			end
			g = " -g " .. vim.fn.shellescape(v)
		end
		-- anything after `--` is text to grep
		rargs = opts.args:sub(j + 1):gsub("^%s+", "")
		if rargs ~= "" then
			query = rargs
		end
	elseif #opts.fargs > 0 then
		query = opts.args
	end
	local preview = vim.fn["fzf#vim#with_preview"]({
		options = {
			"--query",
			query,
			"--delimiter",
			":",
			"--nth",
			"4..",
			"--with-nth",
			"1,2,3,4..",
		},
	})
	rg = "rg --column -n -L --no-heading --color=always -S -. "
		.. "-g '!.git/*' "
		.. g
		.. copts
		.. " -- "
		.. vim.fn["fzf#shellescape"](query)
		.. " "
		.. dir
	vim.fn["fzf#vim#grep"](rg, preview)
end

vim.api.nvim_create_user_command("Fg", function(opts)
	grep_files(opts, vim.fn.expand("."))
end, { desc = "find files", nargs = "*", range = true })
vim.api.nvim_create_user_command("FG", function(opts)
	grep_files(opts, vim.fn.expand("%:p:.:h"))
end, { desc = "find files", nargs = "*", range = true })

vim.env.BAT_THEME = "Solarized (dark)"
vim.env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git"
vim.env.FZF_DEFAULT_OPTS = "--history=" .. os.getenv("HOME") .. "/.fzf_history"
vim.g.fzf_preview_window = { "down:50%" }
vim.g.fzf_files_options = table.concat({
	'--preview "bat --color=always {}"',
}, " ")
-- fF (current buffer's directory), ff (workspace)
vim.keymap.set({ "n", "x" }, "<leader>ff", ":Ff<CR>")
vim.keymap.set({ "n", "x" }, "<leader>fF", ":FF<CR>")
vim.keymap.set("n", "<leader>fb", ":Buffers<CR>")
-- fG (current buffer's directory), fg (workspace)
vim.keymap.set({ "n", "x" }, "<leader>fg", ":Fg<CR>")
vim.keymap.set({ "n", "x" }, "<leader>fG", ":FG<CR>")
vim.keymap.set("n", "<leader>ft", ":Tags<CR>")

-- toggleterm
vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<CR>")
vim.keymap.set("n", "<leader>tb", ":ToggleTerm direction=horizontal<CR>")

-- lspconfig
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, opts)
vim.keymap.set("n", "<C-k>", function()
	vim.lsp.buf.signature_help({ border = "rounded" })
end, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, opts)
-- set capabilities for all installed lsp servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
end

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- solarized
vim.cmd.colorscheme("solarized")

-- aerial
vim.keymap.set("n", "<leader>ds", ":AerialToggle!<CR>")
