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

Example template (single file with MD3 + HSL-derived accents):

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
  "outline_variant": "{{colors.outline_variant.default.hex}}",

  "accent_red": "{{ colors.primary.default.hex | hue: 0 | saturate: 15 | lighten: 5 }}",
  "accent_orange": "{{ colors.primary.default.hex | hue: 30 | saturate: 15 | lighten: 8 }}",
  "accent_yellow": "{{ colors.primary.default.hex | hue: 60 | saturate: 10 | lighten: 12 }}",
  "accent_green": "{{ colors.primary.default.hex | hue: 120 | saturate: 10 | lighten: 6 }}",
  "accent_cyan": "{{ colors.primary.default.hex | hue: 180 | saturate: 10 | lighten: 4 }}",
  "accent_blue": "{{ colors.primary.default.hex | hue: 220 | saturate: 10 | lighten: 2 }}",
  "accent_magenta": "{{ colors.primary.default.hex | hue: 300 | saturate: 15 | lighten: 4 }}"
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
        blink = true,
      },
    },
  },
}
```

Then set:

```lua
vim.cmd.colorscheme("matugen-nvim")
```

Lualine (preserves your existing options):

```lua
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.theme = require("matugen-nvim.integrations.lualine").get()
    opts.options.section_separators = { left = "", right = "" }
    opts.options.component_separators = { left = "", right = "" }
  end,
}
```

Lualine will refresh its theme automatically on palette changes.

### Versioning

This project uses 0versioning: `0.x.y`.

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
  syntax_accent = "hsl",
  integrations = {
    lualine = true,
    snacks = true,
    blink = true,
  },
}
```
