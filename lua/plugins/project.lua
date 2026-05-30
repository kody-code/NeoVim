return {
	"ahmedkhalf/project.nvim",
	opts = {
		manual_mode = false,
		detection_methods = { "lsp", "pattern" },
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
		show_hidden = false,
		silent_chdir = true,
		update_cwd = true,
		update_focused_file = true,
	},
	config = function(_, opts)
		require("project_nvim").setup(opts)
	end,
}
