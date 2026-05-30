return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"bash",
			"html",
			"lua",
			"markdown",
			"python",
			"vim",
			"css",
			"javascript",
			"typescript",
		},
	},
}
