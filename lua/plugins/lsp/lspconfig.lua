return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local function on_attach(client, bufnr)
			-- 格式化配置保持不变
			if client.supports_method("textDocument/formatting") then
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end

			-- 其他 on_attach 配置...
		end

		-- ✅ 修正: 这里使用 LSP 服务器名称 (不是 Mason 包名)
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- LSP 服务器名称
				"pyright", -- LSP 服务器名称 (与包名相同)
				"jsonls", -- JSON LSP 服务器
				"vimls", -- Vim Script LSP 服务器
			},
			handlers = {
				function(server_name)
					local opts = {
						capabilities = capabilities,
						on_attach = on_attach,
					}

					-- 特定服务器配置
					if server_name == "lua_ls" then
						opts.settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
									},
								},
								telemetry = { enable = false },
							},
						}
					end

					require("lspconfig")[server_name].setup(opts)
				end,
			},
		})
	end,
}
