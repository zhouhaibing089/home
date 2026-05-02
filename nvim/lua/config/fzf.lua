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
	-- save the live query
	change = {
		fn = function(selected)
			local state = vim.t.fzf or {}
			state.query = selected[1] or ""
			vim.t.fzf = state
		end,
		field_index = "{q}",
		exec_silent = true,
	},
}
-- exec_opts needs to be a function because vim.uv.cwd() can be different in
-- each invocation, in particular in different tabs.
local exec_opts = function()
	return {
		cwd = vim.fn.getcwd(),
		actions = fzf_actions,
		fzf_opts = fzf_opts,
		no_hide = true, -- tear down fzf on abort/accept
		no_resume = true, -- use <leader>f. for tab-aware resume
	}
end

-- fzf_exec saves the state before calling into fzf.fzf_exec
local fzf_exec = function(cmd, f_opts)
	-- save the last grep state so it can be picked up later
	vim.t.fzf = {
		cmd = cmd,
		exec_opts = f_opts,
	}
	fzf.fzf_exec(cmd, f_opts)
end

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
	query = query or ""
	if opts.range == 2 and opts.line1 == opts.line2 then
		query = get_visual_selection()
		-- normalize path a little bit
		query = vim.fn.simplify(query)
		query = query:gsub("^([%.%.%/|%.%/]+)", "")
	elseif #opts.fargs > 0 then
		query = opts.args
	end
	local cmd = "fd -t f -H -L -E .git -p " .. vim.fn.shellescape(query)
	local title = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	if dir ~= "" and dir ~= "." then
		cmd = cmd .. " " .. dir
		title = title .. "/" .. dir
	end
	local f_opts = vim.tbl_extend("force", exec_opts(), {
		winopts = {
			title = " Files in " .. title .. " ",
		},
		prompt = query == "" and "> " or (query .. " > "),
		previewer = "builtin",
	})
	fzf_exec(cmd, f_opts)
end

vim.api.nvim_create_user_command("Ff", function(opts)
	find_files(opts, vim.t.cwd or "")
end, { desc = "find files", nargs = "*", range = true })
vim.api.nvim_create_user_command("FF", function(opts)
	find_files(opts, vim.fn.expand("%:p:.:h"))
end, { desc = "find files", nargs = "*", range = true })

local function grep_files(opts, dir, query)
	query = query or ""
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
	local cmd = "rg --column -n -L --no-heading --color=always -S -. "
		.. "-g '!.git/*' "
		.. g
		.. copts
		.. " -- "
		.. vim.fn.shellescape(query)
	local title = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	if dir ~= "" and dir ~= "." then
		cmd = cmd .. " " .. dir
		title = title .. "/" .. dir
	end
	local f_opts = vim.tbl_extend("force", exec_opts(), {
		winopts = {
			title = " Grep in " .. title .. " ",
		},
		line_field_index = "{2}",
		fzf_opts = vim.tbl_extend("force", fzf_opts, query == "" and {
			["--delimiter"] = ":",
			["--nth"] = "4..",
			["--with-nth"] = "1,2,3,4..",
		} or {}),
		prompt = query == "" and "> " or (query .. " > "),
		previewer = "builtin",
	})
	fzf_exec(cmd, f_opts)
end

vim.api.nvim_create_user_command("Fg", function(opts)
	grep_files(opts, vim.t.cwd or "")
end, { desc = "find files", nargs = "*", range = true })
vim.api.nvim_create_user_command("FG", function(opts)
	grep_files(opts, vim.fn.expand("%:p:.:h"))
end, { desc = "find files", nargs = "*", range = true })

-- global -{d|r} --result=grep <func>
local function global(opts, def, query)
	query = query or vim.fn.expand("<cword>")
	if opts.range == 2 and opts.line1 == opts.line2 then
		-- query from visual selection
		query = get_visual_selection()
	end
	local cmd, title
	if def then
		cmd = "global -d --result=grep "
		title = " global definitions "
	else
		cmd = "global -r --result=grep "
		title = " global references "
	end
	cmd = cmd .. vim.fn.shellescape(query)
	local f_opts = vim.tbl_extend("force", exec_opts(), {
		winopts = {
			title = title,
		},
		fzf_opts = fzf_opts,
		prompt = query .. " > ",
		previewer = "builtin",
	})
	fzf_exec(cmd, f_opts)
end

vim.api.nvim_create_user_command("Fd", function(opts)
	global(opts, true)
end, { desc = "global definitions", nargs = "*", range = true })
vim.api.nvim_create_user_command("Fr", function(opts)
	global(opts, false)
end, { desc = "global references", nargs = "*", range = true })

-- source graph code search
vim.api.nvim_create_user_command("Zoekt", function(_)
	local f_opts = vim.tbl_extend("force", exec_opts(), {
		winopts = {
			title = " Source Graph ",
		},
		previewer = "builtin",
		no_resume = false,
		no_hide = false,
	})

	fzf.fzf_live(function(items)
		local q = items[1] or ""
		if #q < 3 then
			return ""
		end
		return "zoekt -index_dir .zoekt " .. vim.fn.shellescape(q)
	end, f_opts)
end, { desc = "source graph code search", nargs = 0 })
vim.api.nvim_create_user_command("ZoektIndex", function(_)
	local cwd = vim.fn.getcwd()
	local git_check = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, {
		cwd = cwd,
		text = true,
	}):wait()
	local cmd = git_check.code == 0 and "zoekt-git-index" or "zoekt-index"

	vim.notify("Building zoekt index with " .. cmd, vim.log.levels.INFO)
	vim.system({ cmd, "-index", ".zoekt", "." }, {
		cwd = cwd,
		text = true,
	}, function(result)
		vim.schedule(function()
			if result.code == 0 then
				vim.notify("Zoekt index updated in " .. cwd, vim.log.levels.INFO)
				return
			end

			local err = vim.trim(result.stderr or "")
			if err == "" then
				err = "exit code " .. result.code
			end
			vim.notify("Zoekt indexing failed: " .. err, vim.log.levels.ERROR)
		end)
	end)
end, { desc = "update source graph index" })
vim.keymap.set("n", "<leader>sg", ":Zoekt<CR>", { desc = "source graph code search" })

-- fF (current buffer's directory), ff (workspace)
vim.keymap.set({ "n", "x" }, "<leader>ff", ":Ff<CR>", { desc = "find files" })
vim.keymap.set({ "n", "x" }, "<leader>fF", ":FF<CR>", { desc = "find files in buffer dir" })
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers<CR>", { desc = "find buffers" })
-- fG (current buffer's directory), fg (workspace)
vim.keymap.set({ "n", "x" }, "<leader>fg", ":Fg<CR>", { desc = "file grep" })
vim.keymap.set({ "n", "x" }, "<leader>fG", ":FG<CR>", { desc = "file grep in buffer dir" })
-- tab-aware resume
vim.keymap.set("n", "<leader>f.", function()
	local f = vim.t.fzf or {}
	local cmd = f.cmd or nil
	local f_opts = f.exec_opts and vim.deepcopy(f.exec_opts) or nil
	local query = f.query or ""
	if cmd and f_opts then
		f_opts.query = query
		fzf.fzf_exec(cmd, f_opts)
	end
end, { desc = "fzf resume (customized)" })
-- native resume
vim.keymap.set("n", "<leader>fr", function()
	fzf.resume()
end, { desc = "fzf resume (native)" })
vim.keymap.set("n", "<leader>ft", ":FzfLua tags<CR>", { desc = "find tags" })
-- pin to current buffer's directory
vim.keymap.set("n", "<leader>fp", function()
	if vim.t.cwd then
		vim.t.cwd = nil
	else
		local cwd = vim.fn.expand("%:p:.:h")
		if cwd ~= "." then
			vim.t.cwd = cwd
		else
			vim.t.cwd = nil
		end
	end
	vim.cmd("redrawstatus")
end, { desc = "pin directory for next fuzzy find" })

local function git_blame_lines(opts)
	local name = vim.fn.expand("%")
	local line = vim.fn.line(".") .. "," .. vim.fn.line(".")
	if opts.range == 2 then
		line = opts.line1 .. "," .. opts.line2
	end

	local flag = " -L " .. line .. " -- " .. name
	local cmd = "git blame --color-lines " .. flag
	local f_opts = vim.tbl_extend("force", exec_opts(), {
		winopts = {
			title = " Git Blame (" .. line .. ") ",
		},
		preview = "git show --color {1} -- " .. name,
		actions = {
			["enter"] = actions.git_goto_line,
			["ctrl-s"] = actions.git_buf_split,
			["ctrl-v"] = actions.git_buf_vsplit,
			["ctrl-t"] = actions.git_buf_tabedit,
			["ctrl-y"] = { fn = actions.git_yank_commit, exec_silent = true },
		},
	})
	fzf_exec(cmd, f_opts)
end
vim.api.nvim_create_user_command("Gb", git_blame_lines, {
	desc = "git blame lines",
	nargs = 0,
	range = true,
})

-- gb for line(s) commits and gB for file commits
vim.keymap.set({ "n", "x" }, "<leader>gb", ":Gb<CR>", {
	desc = "git commits for lines",
})
vim.keymap.set({ "n" }, "<leader>gB", ":FzfLua git_blame<CR>", {
	desc = "git commits for buffer",
})

-- a customized explore page for new tab - you can search filenames or contents
local function explore()
	local cmd = "rg --column -n -L --no-heading --color=always -S -. " .. "-g '!.git/*' ''"
	local f_opts = vim.tbl_extend("force", exec_opts(), {
		winopts = {
			title = " Explore in " .. vim.fn.expand("%:p:h:t") .. " ",
		},
		prompt = "> ",
		previewer = "builtin",
	})
	fzf_exec(cmd, f_opts)
end

-- show file finder by default
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.cmd.tcd(arg)
			explore()
		end
	end,
})
vim.api.nvim_create_autocmd("TabNewEntered", {
	callback = function()
		local name = vim.api.nvim_buf_get_name(0)
		if name ~= "" and vim.fn.isdirectory(name) == 1 then
			vim.cmd.tcd(name)
			explore()
		end
	end,
})
