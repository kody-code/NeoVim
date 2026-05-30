return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		view = {
			width = 30,
		},
		renderer = {
			group_empty = true,
		},
		actions = {
			open_file = {
				window_picker = {
					enable = false,
				},
			},
		},
		filters = {
			dotfiles = false,
			exclude = { ".git", "node_modules" },
		},
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "切换文件树" })
	end,
}
