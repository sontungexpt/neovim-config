## Neovim Config

This is my personal neovim configuration, written completely in Lua. It uses a lazy plugin manager to ensure fast startup times, even with a large number of plugins installed.

## Preview

![preview1](./docs/readme/preview1.png)

![preview2](./docs/readme/preview2.png)

![preview3](./docs/readme/preview3.png)

![preview4](./docs/readme/preview4.png)

## Features

- **lazy:** Uses a lazy plugin manager to ensure fast startup times.

- **copilot:** Enables support for OpenAI's Copilot.

- **nvim-cmp:** Provides autocomplete functionality using nvim-cmp, a lightweight completion plugin.

- **nvim-lspconfig:** Implements Language Server Protocol (LSP) support using nvim-lspconfig, a simple interface for configuring language servers.

- **null-ls:** Enables automatic formatting with null-ls, a plugin that allows using external formatters as Neovim plugins.

- **mason:** Automatically installs LSP servers, formatters, linters, and debug adapters using Mason, a Neovim plugin manager.

- **nvim-tree:** Includes a file explorer using nvim-tree, a fast and lightweight file explorer plugin.

- **gitsigns, git-conflict:** Integrates Git functionality with gitsigns and git-conflict plugins for a seamless Git experience.

- **telescope:** Provides a file finder using telescope, a fuzzy finder plugin for files, buffers, and more.

- **bufferline:** Manages buffers with bufferline, a simple and configurable interface for buffer management.

- **lualine:** Displays a statusline using lualine, a fast and lightweight statusline plugin with customizable options.

- **toggleterm:** Includes a terminal using toggleterm, a plugin for managing terminals within Neovim.

- **nvim-ufo:** Supports folding functionality with nvim-ufo, a lightweight folding plugin.

- **comment:** Includes a plugin for easily generating comments.

- **treesitter, autopairs, nvim-ts-autotag, ts-rainbow:** Provides syntax highlighting using Treesitter, Autopairs, Nvim-ts-autotag, and Ts-rainbow plugins.

- **dap, dapui:** Offers debugging capabilities with dap and dapui plugins.

- **buffer-closer:** Automatically closes unused buffers using buffer-closer, a plugin for managing buffers.

- **ccc:** Includes a color picker using ccc, a fast and lightweight color picker plugin

- **focus:** Automatically resizes windows based on focus using a dedicated plugin.

## Installation

To use this configuration, you will need to have Neovim 0.5 or higher installed. You can then clone this repository and copy the init.lua file to your ~/.config/nvim/ directory.

```bash
mv ~/.config/nvim ~/.config/nvim.bak && git clone https://github.com/sontungexpt/neovim-config.git  ~/.config/nvim
```

You will also need to install the plugins. This configuration uses the lazy.nvim plugin manager to manage plugins. You can install the plugins by opening Neovim and running :Lazy.

```vim
:Lazy
```

## Inspiration

- [NvChad](https://github.com/NvChad/NvChad)

## Configuration

This configuration is highly customizable and easy to configure. You can customize the configuration by modifying the init.lua file.

## Contributions

If you find any issues with this configuration or would like to contribute, please feel free to submit a pull request or open an issue.

## License

This configuration is released under the MIT License.
