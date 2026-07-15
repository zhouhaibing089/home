local fzf = require("fzf-lua")
local utils = require("fzf-lua.utils")

-- files_prompt returns the prompt for cwd
local function files_prompt(dir)
	if dir then
		return dir .. " > "
	end
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " > "
end

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
			fzf.vcs_files({
				cwd_prompt = false,
				cwd_header = false,
				prompt = files_prompt(),
				git_icons = false,
			})
		end
	end,
})
vim.api.nvim_create_autocmd("TabNewEntered", {
	callback = function()
		local name = vim.api.nvim_buf_get_name(0)
		if name ~= "" and vim.fn.isdirectory(name) == 1 then
			vim.cmd.tcd(name)
			fzf.vcs_files({
				cwd_prompt = false,
				cwd_header = false,
				prompt = files_prompt(),
				git_icons = false,
			})
		end
	end,
})

-- find files
vim.keymap.set({ "n" }, "<leader>ff", function()
	fzf.vcs_files({
		cwd = vim.w.cwd or vim.t.cwd or vim.fn.getcwd(),
		cwd_prompt = false,
		cwd_header = false,
		prompt = files_prompt(vim.w.cwd or vim.t.cwd),
		git_icons = false,
	})
end, { desc = "find files" })
vim.keymap.set({ "n" }, "<leader>fF", function()
	fzf.vcs_files({
		cwd = vim.fn.getcwd(),
		cwd_prompt = false,
		cwd_header = false,
		prompt = files_prompt(),
		git_icons = false,
	})
end, { desc = "find files (global)" })
vim.keymap.set({ "v" }, "<leader>ff", function()
	local query = vim.fn.simplify((utils.get_visual_selection()))
	fzf.vcs_files({
		cwd = vim.w.cwd or vim.t.cwd or vim.fn.getcwd(),
		cwd_prompt = false,
		cwd_header = false,
		prompt = files_prompt(vim.w.cwd or vim.t.cwd),
		query = query:gsub("^([%.%.%/|%.%/]+)", ""),
		git_icons = false,
	})
end, { desc = "find files" })
vim.keymap.set({ "v" }, "<leader>fF", function()
	local query = vim.fn.simplify((utils.get_visual_selection()))
	fzf.vcs_files({
		cwd = vim.fn.getcwd(),
		cwd_prompt = false,
		cwd_header = false,
		prompt = files_prompt(),
		query = query:gsub("^([%.%.%/|%.%/]+)", ""),
		git_icons = false,
	})
end, { desc = "find files (global)" })
vim.keymap.set("n", "<leader>fb", function()
	fzf.buffers()
end, { desc = "find buffers" })

-- file grep
vim.keymap.set({ "n" }, "<leader>fg", function()
	fzf.live_grep({
		cwd = vim.w.cwd or vim.t.cwd or vim.fn.getcwd(),
	})
end, { desc = "file grep" })
vim.keymap.set({ "n" }, "<leader>fG", function()
	fzf.live_grep({
		cwd = vim.fn.getcwd(),
	})
end, { desc = "file grep (global)" })
vim.keymap.set({ "n" }, "<leader>/", function()
	fzf.grep({
		cwd = vim.w.cwd or vim.t.cwd or vim.fn.getcwd(),
		search = vim.fn.expand("<cword>"),
	})
end, { desc = "file grep" })
vim.keymap.set({ "v" }, "<leader>fg", function()
	fzf.grep_visual({
		cwd = vim.w.cwd or vim.t.cwd or vim.fn.getcwd(),
	})
end, { desc = "file grep" })
vim.keymap.set({ "v" }, "<leader>fG", function()
	fzf.grep_visual({
		cwd = vim.fn.getcwd(),
	})
end, { desc = "file grep (global)" })

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

-- git diff or status
vim.keymap.set("n", "<leader>gs", function()
	fzf.git_status({
		winopts = {
			preview = { layout = "vertical", vertical = "down:75%" },
		},
	})
end, { desc = "git diff" })
vim.keymap.set("n", "<leader>gd", function()
	fzf.git_diff({
		winopts = {
			preview = { layout = "vertical", vertical = "down:75%" },
		},
	})
end, { desc = "git diff" })
