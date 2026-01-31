local conform = require("conform")

conform.formatters.shfmt = {
	-- always use two spaces instead of tabs
	append_args = { "-i", "2" },
}
