local fzf = require("fzf-lua")
local actions = require("fzf-lua.actions")

local fzf_opts = {
	["--ansi"] = true,
	["--info"] = "inline-right",
	["--height"] = "100%",
	["--layout"] = "reverse",
	["--border"] = "none",
	["--highlight-line"] = true,
	["--history"] = os.getenv("HOME") .. "/.fzf_history",
}
local fzf_actions = {
	["default"] = actions.file_edit,
	["ctrl-s"] = actions.file_split,
	["ctrl-v"] = actions.file_vsplit,
}
local exec_opts = {
	cwd = vim.uv.cwd(),
	previewer = "bat",
	actions = fzf_actions,
	fzf_opts = fzf_opts,
}

vim.env.BAT_THEME = "Solarized (dark)"

local function get_visual_selection()
	-- visual mode with selection that in the same line
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local region = vim.fn.getregion(start_pos, end_pos, {
		type = vim.fn.visualmode(),
	})
	return region[1]
end

local function find_files(opts, dir, query)
	local query = query or ""
	if opts.range == 2 and opts.line1 == opts.line2 then
		query = get_visual_selection()
	elseif #opts.fargs > 0 then
		query = opts.args
	end
	fd = "fd -t f -H -L -E .git " .. vim.fn.shellescape(query) .. " " .. dir
	vim.notify(fd, vim.log.levels.DEBUG)
	fzf.fzf_exec(
		fd,
		vim.tbl_extend("force", exec_opts, {
			winopts = {
				title = " Files (" .. dir .. ") ",
				preview = { layout = "down", size = "50%" },
			},
			prompt = query == "" and "> " or (query .. " > "),
		})
	)
end

vim.api.nvim_create_user_command("Ff", function(opts)
	find_files(opts, "")
end, { desc = "find files", nargs = "*", range = true })
vim.api.nvim_create_user_command("FF", function(opts)
	find_files(opts, vim.fn.expand("%:p:.:h"))
end, { desc = "find files", nargs = "*", range = true })

local function grep_files(opts, dir, query)
	local query = query or ""
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
			g = g .. " -g " .. vim.fn.shellescape(v)
		end
		-- anything after `--` is text to grep
		local rargs = opts.args:sub(j + 1):gsub("^%s+", "")
		if rargs ~= "" then
			query = rargs
		end
	elseif #opts.fargs > 0 then
		query = opts.args
	end
	local rg = "rg --column -n -L --no-heading --color=always -S -. "
		.. "-g '!.git/*' "
		.. g
		.. copts
		.. " -- "
		.. vim.fn.shellescape(query)
		.. " "
		.. dir
	-- save the last grep state so it can be picked up later
	vim.g.t = vim.tbl_extend("force", vim.g.t or {}, {
		rg = rg,
		query = query,
		dir = dir,
	})
	vim.notify(rg, vim.log.levels.DEBUG)
	fzf.fzf_exec(
		rg,
		vim.tbl_extend("force", exec_opts, {
			winopts = {
				title = " Grep (" .. dir .. ") ",
				preview = { layout = "down", size = "50%" },
			},
			fzf_opts = vim.tbl_extend("force", fzf_opts, {
				["--delimiter"] = ":",
				["--nth"] = "4..",
				["--with-nth"] = "1,2,3,4..",
			}),
			prompt = query == "" and "> " or (query .. " > "),
		})
	)
end

vim.api.nvim_create_user_command("Fg", function(opts)
	grep_files(opts, "")
end, { desc = "find files", nargs = "*", range = true })
vim.api.nvim_create_user_command("FG", function(opts)
	grep_files(opts, vim.fn.expand("%:p:.:h"))
end, { desc = "find files", nargs = "*", range = true })

-- fF (current buffer's directory), ff (workspace)
vim.keymap.set({ "n", "x" }, "<leader>ff", ":Ff<CR>")
vim.keymap.set({ "n", "x" }, "<leader>fF", ":FF<CR>")
vim.keymap.set("n", "<leader>fb", ":Buffers<CR>")
-- fG (current buffer's directory), fg (workspace)
vim.keymap.set({ "n", "x" }, "<leader>fg", ":Fg<CR>")
vim.keymap.set({ "n", "x" }, "<leader>fG", ":FG<CR>")
vim.keymap.set("n", "<leader>f.", function()
	vim.g.t = vim.g.t or {}
	local rg = vim.g.t.rg
		or "rg --column -n -L --no-heading --color=always -S -. "
			.. "-g '!.git/*' "
			.. " -- "
			.. " "
			.. vim.fn.shellescape("")
			.. vim.uv.cwd()
	local dir = vim.g.t.dir or vim.uv.cwd()
	local query = vim.g.t.query or ""
	fzf.fzf_exec(
		rg,
		vim.tbl_extend("force", exec_opts, {
			winopts = {
				title = " Grep (" .. dir .. ") ",
				preview = { layout = "down", size = "50%" },
			},
			fzf_opts = vim.tbl_extend("force", fzf_opts, {
				["--delimiter"] = ":",
				["--nth"] = "4..",
				["--with-nth"] = "1,2,3,4..",
			}),
			prompt = query == "" and "> " or (query .. " > "),
		})
	)
end)
vim.keymap.set("n", "<leader>ft", ":Tags<CR>")
