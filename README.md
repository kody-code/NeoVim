# Neovim 配置

## 简介

基于 Neovim 的现代化开发环境配置，集成 LSP、补全、调试、格式化等功能。

## 安装

```bash
git clone https://github.com/kody-code/NeoVim.git ~/.config/nvim
nvim
```

Mason 会自动安装 LSP 服务器和格式化工具。

## 要求

- Neovim >= 0.10.0
- Git
- 终端使用 Nerd Font（推荐 JetBrains Mono Nerd Font）

## 目录结构

```
nvim/
├── init.lua               # 入口
├── lazy-lock.json
├── lua/
│   ├── config/            # 基础配置
│   │   ├── basic.lua
│   │   └── lazy.lua       # lazy.nvim 安装
│   ├── plugins/           # 插件配置
│   │   ├── init.lua       # lazy 启动入口
│   │   ├── lsp/           # LSP / DAP / 补全 / 格式化
│   │   │   ├── init.lua   # LSP 插件聚合
│   │   │   ├── mason.lua
│   │   │   ├── lspconfig.lua
│   │   │   ├── cmp.lua
│   │   │   ├── dap.lua
│   │   │   └── conform.lua
│   │   └── ...
│   └── scripts/
└── README.md
```

## 快捷键

| 快捷键 | 功能 |
|--------|------|
| `<leader>t` | 打开终端 |
| `<leader>e` | 切换文件树 |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索 |
| `<leader>fb` | 切换缓冲区 |
| `<leader>fh` | 搜索帮助 |
| `<leader>f` | 格式化 |
| `<leader>ft` | 检查格式化工具 |
| `<leader>rr` / `<F5>` | 运行当前文件 |
| `gd` / `gD` / `gi` / `gr` | LSP 导航 |
| `K` | 悬浮信息 |
| `<leader>rn` | 重命名 |
| `<leader>ca` | 代码操作 |
| `<C-a>` / `<C-x>` / `<C-.>` | opencode AI |
| `<F6>` / `<F10>` / `<F11>` / `<F12>` | DAP 调试 |
| `<leader>b` | 切换断点 |
| `:EditConfig` | 编辑配置 |
| `:ReloadConfig` | 重载配置 |
