return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local ts_conds = require("nvim-autopairs.ts-conds") -- 正确导入条件模块

		-- 基础配置（来自官方示例）
		npairs.setup({
			check_ts = true, -- 启用 Treesitter 检查
			ts_config = {
				lua = { "string" }, -- 在 Lua 的 string 节点中不添加配对
				javascript = { "template_string" }, -- 在 JS 模板字符串中不添加配对
				java = false, -- 在 Java 中不检查 Treesitter
				python = { "string", "comment" }, -- 在 Python 字符串和注释中不添加配对
				cpp = { "string", "comment" },
				rust = { "string", "comment" },
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel", "lspinfo", "dashboard" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'", "`" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		})

		-- 在 string 或 comment 节点中添加 % 配对
		npairs.add_rules({
			Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),

			-- 在非 function 节点中添加 $ 配对
			Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),

			-- 在非 string 和非 comment 节点中添加引号配对
			Rule("'", "'", "lua"):with_pair(ts_conds.is_not_ts_node({ "string", "comment" })),
			Rule('"', '"', "lua"):with_pair(ts_conds.is_not_ts_node({ "string", "comment" })),
			Rule("`", "`", "lua"):with_pair(ts_conds.is_not_ts_node({ "string", "comment" })),

			-- Python 规则：在非字符串、非注释、非函数参数节点中添加括号
			Rule("(", ")", "python"):with_pair(ts_conds.is_not_ts_node({ "string", "comment", "parameters" })),

			-- JavaScript/TS 规则
			Rule("(", ")", "javascript"):with_pair(ts_conds.is_not_ts_node({ "string", "comment", "template_string" })),
			Rule("(", ")", "typescript"):with_pair(ts_conds.is_not_ts_node({ "string", "comment", "template_string" })),
		})

		-- 与 nvim-cmp 集成
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- 智能回车：在括号内按回车时自动缩进
		npairs.add_rule(Rule("\n", "\n")
			:with_pair(function(opts)
				local line = opts.line
				local before = line:sub(1, opts.col - 1)
				local after = line:sub(opts.col)
				local pair = before:sub(-1) .. after:sub(1)
				return pair == "{}" or pair == "[]" or pair == "()"
			end)
			:with_move(function(opts)
				return opts.char == "\n"
			end)
			:use_key("\n"))

		-- 在 % 后面不添加额外的 ) 例如: %(xxx|) -> %(xxx|)
		npairs.add_rule(Rule(")", ")"):with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return pair == "(%"
		end))

		-- Markdown 链接规则
		npairs.add_rules({
			Rule("[", "]", "markdown"):with_pair(function(opts)
				local before = opts.line:sub(1, opts.col - 1)
				return not before:match("%[.-%]%(") -- 不在已有的链接后添加
			end),
			Rule("(", ")", "markdown"):with_pair(function(opts)
				local before = opts.line:sub(1, opts.col - 2)
				return before:match("%[.-%]$") -- 只在 [text] 后添加
			end),
		})

		-- 快捷键映射
		local opts = { noremap = true, silent = true, expr = true }

		-- 智能回车（处理括号和 completion）
		vim.keymap.set("i", "<CR>", function()
			if vim.fn.pumvisible() == 1 then
				return "<C-e><CR>"
			end
			return npairs.autopairs_cr()
		end, opts)

		-- 跳过右侧括号
		vim.keymap.set("i", ")", function()
			if npairs.jumpable() then
				return "<Plug>nvim-autopairs-jump-right"
			else
				return ")"
			end
		end, opts)

		vim.keymap.set("i", "}", function()
			if npairs.jumpable() then
				return "<Plug>nvim-autopairs-jump-right"
			else
				return "}"
			end
		end, opts)

		vim.keymap.set("i", "]", function()
			if npairs.jumpable() then
				return "<Plug>nvim-autopairs-jump-right"
			else
				return "]"
			end
		end, opts)

		-- 智能退格
		vim.keymap.set("i", "<BS>", function()
			return npairs.autopairs_bs()
		end, opts)

		-- 快速包裹
		vim.keymap.set("v", "<M-e>", "<Plug>nvim-autopairs-fast-wrap", { noremap = true })
	end,
}
