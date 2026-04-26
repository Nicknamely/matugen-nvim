## matugen-nvim

Neovim colorscheme that follows a matugen-generated Material You palette.

Highlights:
- Reads a matugen JSON palette and applies full highlight groups.
- Keeps `termguicolors` enabled, with transparent main windows and solid floats.
- Watches the palette file and hot-reloads on changes.
- Optional lualine and snacks.nvim integration.

### Requirements
- Neovim 0.9+ (uses `vim.uv` and `vim.json`)
- A matugen template that outputs JSON

### Matugen template
Add a JSON template and output path in your matugen config:

```toml
[templates.nvim]
input_path  = "~/.config/matugen/templates/nvim.json"
output_path = "~/.cache/matugen/nvim-colors.json"
```

Example template:

```json
{
  "primary": "{{colors.primary.default.hex}}",
  "on_primary": "{{colors.on_primary.default.hex}}",
  "secondary": "{{colors.secondary.default.hex}}",
  "on_secondary": "{{colors.on_secondary.default.hex}}",
  "surface": "{{colors.surface.default.hex}}",
  "on_surface": "{{colors.on_surface.default.hex}}",
  "surface_variant": "{{colors.surface_variant.default.hex}}",
  "on_surface_variant": "{{colors.on_surface_variant.default.hex}}",
  "background": "{{colors.background.default.hex}}",
  "on_background": "{{colors.on_background.default.hex}}",
  "error": "{{colors.error.default.hex}}",
  "on_error": "{{colors.on_error.default.hex}}",
  "tertiary": "{{colors.tertiary.default.hex}}",
  "outline": "{{colors.outline.default.hex}}",
  "outline_variant": "{{colors.outline_variant.default.hex}}"
}
```

### Installation (lazy.nvim / LazyVim)

```lua
return {
  {
    "yourname/matugen-nvim",
    lazy = false,
    priority = 1000,
    opts = {
      palette_path = "~/.cache/matugen/nvim-colors.json",
      transparent = true,
      watch = true,
      float_bg_blend = 0.6,
      integrations = {
        lualine = true,
        snacks = true,
      },
    },
  },
}
```

Then set:

```lua
vim.cmd.colorscheme("matugen-nvim")
```

### Installation (vim-plug / pack)

`vim-plug`:

```vim
Plug 'yourname/matugen-nvim'
```

`pack` (native packages):

```sh
git clone https://github.com/yourname/matugen-nvim ~/.local/share/nvim/site/pack/matugen/start/matugen-nvim
```

Then in your config:

```lua
require("matugen-nvim").setup({
  palette_path = "~/.cache/matugen/nvim-colors.json",
  transparent = true,
  watch = true,
  float_bg_blend = 0.6,
  integrations = {
    lualine = true,
    snacks = true,
    blink = true,
  },
})

vim.cmd.colorscheme("matugen-nvim")
```

### Configuration

Defaults in `lua/matugen-nvim/config.lua`:

```lua
{
  palette_path = "~/.cache/matugen/nvim-colors.json",
  transparent = true,
  watch = true,
  watch_debounce_ms = 120,
  float_bg_blend = 0.6,
  integrations = {
    lualine = true,
    snacks = true,
    blink = true,
  },
}
```
