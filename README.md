# Gruvbox

A really simple [gruvbox color scheme][gruvbox] for Neovim, written to be as
simple as it gets and based on my [solarized theme][solarized].

[gruvbox]: https://github.com/morhetz/gruvbox
[solarized]: https://github.com/fschauen/solarized.nvim

## Why?

Why not? 😉

## Getting Started

### Requirements

- Neovim (duh 😛)
- `vim.opt.termguicolors = true` in your `init.lua`.
- A terminal with [true color support][truecolor].

[truecolor]: https://github.com/termstandard/colors

### Installation

Install with your favorite package manager, e.g with [lazy.nvim][lazy]:

```lua
require('lazy').setup {
  'fschauen/gruvbox.nvim'
}
```

[lazy]: https://github.com/folke/lazy.nvim

### Setup

Just type:

```viml
:colorscheme gruvbox
```

or add this to your `init.lua`:

```lua
vim.cmd [[colorscheme gruvbox]]
```

### Options

None. This is supposed to be simple, remember?

## Supported Plugins

- [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [lualine](https://github.com/nvim-lualine/lualine.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- [telescope](https://github.com/nvim-telescope/telescope.nvim)
- [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [virt-column.nvim](https://github.com/lukas-reineke/virt-column.nvim)

