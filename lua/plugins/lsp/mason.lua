return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
		max_concurrent_installers = 10,
	},
	config = function(_, opts)
		require("mason").setup(opts)
		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua-language-server",
				"pyright",
				"vim-language-server",
				"stylua",
				"prettier",
				"eslint_d",
				"black",
				"isort",
				"shfmt",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}
