local fzf = require("fzf-lua")
local utils = require("fzf-lua.utils")

-- files_prompt returns the prompt for cwd
local function files_prompt(dir)
	if dir then
		return dir .. " > "
	end
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " > "
end

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

-- resume
vim.keymap.set("n", "<leader>f.", function()
	fzf.resume()
end, { desc = "fzf resume" })

-- show file finder by default
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.cmd.tcd(arg)
			fzf.files({
				cwd_prompt = false,
				cwd_header = false,
				prompt = files_prompt(),
			})
		end
	end,
})
vim.api.nvim_create_autocmd("TabNewEntered", {
	callback = function()
		local name = vim.api.nvim_buf_get_name(0)
		if name ~= "" and vim.fn.isdirectory(name) == 1 then
			vim.cmd.tcd(name)
			fzf.files({
				cwd_prompt = false,
				cwd_header = false,
				prompt = files_prompt(),
			})
		end
	end,
})

-- find files
vim.keymap.set({ "n" }, "<leader>ff", function()
	fzf.files({
		cwd = vim.t.cwd or vim.fn.getcwd(),
		cwd_prompt = false,
		cwd_header = false,
		prompt = files_prompt(vim.t.cwd),
	})
end, { desc = "find files" })
vim.keymap.set({ "v" }, "<leader>ff", function()
	fzf.files({
		cwd = vim.t.cwd or vim.fn.getcwd(),
		cwd_prompt = false,
		cwd_header = false,
		prompt = files_prompt(vim.t.cwd),
		query = utils.get_visual_selection(),
	})
end, { desc = "find files" })
vim.keymap.set("n", "<leader>fb", function()
	fzf.buffers()
end, { desc = "find buffers" })

-- file grep
vim.keymap.set({ "n" }, "<leader>fg", function()
	fzf.live_grep({
		cwd = vim.t.cwd or vim.fn.getcwd(),
	})
end, { desc = "file grep" })
vim.keymap.set({ "v" }, "<leader>fg", function()
	fzf.grep_visual({
		cwd = vim.t.cwd or vim.fn.getcwd(),
	})
end, { desc = "file grep" })

-- git blame
vim.keymap.set({ "n" }, "<leader>gb", function()
	fzf.git_blame()
end, { desc = "git commits for lines" })

-- global (gtags/ctags based) definitions and references
vim.keymap.set({ "n" }, "<leader>fd", function()
	fzf.grep({
		cmd = "global -d --result=grep",
		silent = true,
		winopts = {
			title = " Global Definitions ",
		},
		search = vim.fn.expand("<cword>"),
	})
end, { desc = "global definitions" })
vim.keymap.set({ "v" }, "<leader>fd", function()
	fzf.grep({
		cmd = "global -d --result=grep",
		silent = true,
		winopts = {
			title = " Global Definitions ",
		},
		search = utils.get_visual_selection(),
	})
end, { desc = "global definitions" })
vim.keymap.set({ "n" }, "<leader>fr", function()
	fzf.grep({
		cmd = "global -r --result=grep",
		silent = true,
		winopts = {
			title = " Global References ",
		},
		search = vim.fn.expand("<cword>"),
	})
end, { desc = "global references" })
vim.keymap.set({ "v" }, "<leader>fr", function()
	fzf.grep({
		cmd = "global -r --result=grep",
		silent = true,
		winopts = {
			title = " Global References ",
		},
		search = utils.get_visual_selection(),
	})
end, { desc = "global references" })

-- zoekt (aka source graph)
vim.keymap.set("n", "<leader>sg", function()
	fzf.live_grep({
		cmd = "zoekt -index_dir .zoekt",
		silent = true,
		winopts = {
			title = " Source Graph ",
		},
	})
end, { desc = "source graph code search" })
vim.keymap.set("v", "<leader>sg", function()
	fzf.grep({
		cmd = "zoekt -index_dir .zoekt",
		silent = true,
		winopts = {
			title = " Source Graph ",
		},
		search = utils.get_visual_selection(),
	})
end, { desc = "source graph code search" })
vim.api.nvim_create_user_command("ZoektIndex", function()
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
