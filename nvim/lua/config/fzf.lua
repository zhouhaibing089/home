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
