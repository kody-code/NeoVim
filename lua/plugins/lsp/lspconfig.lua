return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local function on_attach(_client, bufnr)
			local map = function(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
			end
			map("gd", vim.lsp.buf.definition, "跳转到定义")
			map("gD", vim.lsp.buf.declaration, "跳转到声明")
			map("gi", vim.lsp.buf.implementation, "跳转到实现")
			map("gr", vim.lsp.buf.references, "查找引用")
			map("K", vim.lsp.buf.hover, "显示信息")
			map("<leader>rn", vim.lsp.buf.rename, "重命名")
			map("<leader>ca", vim.lsp.buf.code_action, "代码操作")
			map("<leader>so", vim.lsp.buf.signature_help, "签名帮助")
			map("[d", vim.diagnostic.goto_prev, "上一个诊断")
			map("]d", vim.diagnostic.goto_next, "下一个诊断")
			map("<leader>q", vim.diagnostic.setloclist, "快速修复")
		end

		local server_configs = {
			lua_ls = {
				settings = {
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
				},
			},
			gopls = {
				settings = {
					gopls = {
						gofumpt = true, -- 使用 gofumpt 格式化
						usePlaceholders = true,
						completeUnimported = true,
						analyses = {
							unusedparams = true,
							shadow = true,
						},
					},
				},
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						checkOnSave = {
							command = "clippy", -- 使用 clippy 进行代码检查
						},
					},
				},
			},
		}

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"jsonls",
				"vimls",
			},
			handlers = {
				function(server_name)
					local config = server_configs[server_name] or {}
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = config.settings or {},
					})
				end,
			},
		})
	end,
}
