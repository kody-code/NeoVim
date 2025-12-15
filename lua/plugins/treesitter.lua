return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"c++",
				"vim",
				"lua",
				"javascript",
				"typescript",
				"python",
				"html",
				"css",
				"markdown",
				"go",
				"rust",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
	event = "BufReadPost",
}
