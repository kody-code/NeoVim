return {
	-- theme 主题
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night", -- night/storm/day/moon
			transparent = false, -- 透明背景
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd("colorscheme tokyonight")
		end,
	},
	-- lualine 状态栏
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "dashboard", "NvimTree" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
	-- notify 通知
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#000000",
			render = "minimal",
			stages = "fade_in_slide_out",
		},
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify")
		end,
		event = "VeryLazy",
	},
	-- noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			routes = {
				{
					view = "popup",
					filter = { event = "cmp" },
				},
			},
		},
	},
	-- 启动页
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = {
			theme = "hyper",
			config = {
				mru = { enable = true, limit = 5 },
				header = {
					"",
					"",
					"    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
					"    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
					"    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
					"    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
					"    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
					"    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
				},
				center = {
					{ icon = "  ", desc = "Projects", action = "Telescope projects" },
					{ icon = "  ", desc = "Recent Files", action = "Telescope oldfiles" },
					{ icon = "  ", desc = "Find File", action = "Telescope find_files" },
					{ icon = "  ", desc = "Find Text", action = "Telescope live_grep" },
				},
				footer = { "Neovim - 高效 · 简洁 · 美观" },
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "buffers",
				show_close_icon = false,
				show_tab_indicators = false,
				separator_style = "thin", -- 细线风格，和 tree 最搭
				always_show_bufferline = true,
				show_buffer_close_icons = false,

				-- 👇 关键：让 NvimTree 不显示标签，完美对齐
				offsets = {
					{
						filetype = "NvimTree",
						text = "📁 File Explorer",
						highlight = "Directory",
						text_align = "left",
						separator = true,
					},
				},

				-- 诊断图标
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		},
	},
}
