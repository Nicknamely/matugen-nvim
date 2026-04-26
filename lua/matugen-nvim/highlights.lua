local M = {}

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function blend_hex(fg, bg, alpha)
  local r1, g1, b1 = hex_to_rgb(fg)
  local r2, g2, b2 = hex_to_rgb(bg)
  local r = math.floor(r1 * alpha + r2 * (1 - alpha))
  local g = math.floor(g1 * alpha + g2 * (1 - alpha))
  local b = math.floor(b1 * alpha + b2 * (1 - alpha))
  return string.format("#%02x%02x%02x", r, g, b)
end

local function set(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

function M.apply(c, opts)
  local bg_main = opts.transparent and "NONE" or c.background
  local float_bg = blend_hex(c.surface, c.background, opts.float_bg_blend or 0.6)
  local selection = blend_hex(c.primary, c.background, 0.25)
  local line_bg = blend_hex(c.surface, c.background, 0.3)
  local comment_fg = blend_hex(c.on_surface_variant, c.background, 0.7)
  local cursor_bg = c.on_background
  local cursor_fg = c.background
  local function pick(value, fallback)
    if value and value:sub(1, 1) == "#" then
      return value
    end
    return fallback
  end

  local syntax
  if opts.syntax_accent == "base16" then
    syntax = {
      comment = pick(c.base03, comment_fg),
      keyword = pick(c.base0e, c.primary),
      func = pick(c.base0d, c.secondary),
      type = pick(c.base0a, c.tertiary),
      string = pick(c.base0b, c.tertiary),
      number = pick(c.base09, c.on_secondary),
      boolean = pick(c.base09, c.on_secondary),
      constant = pick(c.base0c, c.on_secondary),
      ident = pick(c.base05, c.on_surface),
      operator = pick(c.base05, c.outline),
      param = pick(c.base04, c.on_surface_variant),
      special = pick(c.base0c, c.tertiary),
      error = pick(c.base08, c.error),
    }
  else
    syntax = {
      comment = comment_fg,
      keyword = c.primary,
      func = c.secondary,
      type = c.tertiary,
      string = c.tertiary,
      number = c.on_secondary,
      boolean = c.on_secondary,
      constant = c.on_secondary,
      ident = c.on_surface,
      operator = c.outline,
      param = c.on_surface_variant,
      special = c.tertiary,
      error = c.error,
    }
  end

  set("Normal", { fg = c.on_background, bg = bg_main })
  set("NormalNC", { fg = c.on_surface, bg = bg_main })
  set("Cursor", { fg = cursor_fg, bg = cursor_bg })
  set("TermCursor", { fg = cursor_fg, bg = cursor_bg })
  set("TermCursorNC", { fg = cursor_fg, bg = cursor_bg })
  set("NormalFloat", { fg = c.on_surface, bg = float_bg })
  set("FloatBorder", { fg = c.outline, bg = float_bg })
  set("FloatTitle", { fg = c.primary, bg = float_bg, bold = true })

  set("SignColumn", { bg = bg_main })
  set("LineNr", { fg = c.outline, bg = bg_main })
  set("CursorLineNr", { fg = c.primary, bg = bg_main, bold = true })
  set("CursorLine", { bg = line_bg })
  set("ColorColumn", { bg = line_bg })

  set("StatusLine", { fg = c.on_surface, bg = c.surface })
  set("StatusLineNC", { fg = c.outline, bg = c.surface })
  set("TabLine", { fg = c.outline, bg = c.surface })
  set("TabLineSel", { fg = c.on_primary, bg = c.primary, bold = true })
  set("TabLineFill", { bg = c.background })

  set("Pmenu", { fg = c.on_surface, bg = float_bg })
  set("PmenuSel", { fg = c.on_primary, bg = c.primary })
  set("PmenuSbar", { bg = c.surface_variant })
  set("PmenuThumb", { bg = c.outline })

  set("Visual", { bg = selection })
  set("Search", { fg = c.on_primary, bg = c.primary })
  set("IncSearch", { fg = c.on_secondary, bg = c.secondary })
  set("MatchParen", { fg = c.tertiary, bold = true, underline = true })

  set("WinSeparator", { fg = c.outline_variant, bg = bg_main })
  set("VertSplit", { fg = c.outline_variant, bg = bg_main })
  set("EndOfBuffer", { fg = c.outline })

  set("DiagnosticError", { fg = c.error })
  set("DiagnosticWarn", { fg = c.tertiary })
  set("DiagnosticInfo", { fg = c.secondary })
  set("DiagnosticHint", { fg = c.on_surface_variant })
  set("DiagnosticUnderlineError", { sp = c.error, undercurl = true })
  set("DiagnosticUnderlineWarn", { sp = c.tertiary, undercurl = true })

  set("Comment", { fg = syntax.comment, italic = true })
  set("Keyword", { fg = syntax.keyword, bold = true })
  set("Function", { fg = syntax.func })
  set("String", { fg = syntax.string })
  set("Number", { fg = syntax.number })
  set("Boolean", { fg = syntax.boolean, italic = true })
  set("Constant", { fg = syntax.constant })
  set("Type", { fg = syntax.type, italic = true })
  set("Identifier", { fg = syntax.ident })
  set("Operator", { fg = syntax.operator })
  set("PreProc", { fg = syntax.keyword })
  set("Special", { fg = syntax.special })
  set("Error", { fg = syntax.error })
  set("Todo", { fg = c.on_primary, bg = c.primary, bold = true })

  set("@keyword", { link = "Keyword" })
  set("@keyword.function", { fg = syntax.keyword, italic = true })
  set("@keyword.return", { fg = syntax.keyword, bold = true })
  set("@function", { link = "Function" })
  set("@function.builtin", { fg = syntax.func, italic = true })
  set("@function.method", { fg = syntax.func })
  set("@constructor", { fg = syntax.func, bold = true })
  set("@variable", { fg = syntax.ident })
  set("@variable.builtin", { fg = syntax.keyword, italic = true })
  set("@variable.parameter", { fg = syntax.param, italic = true })
  set("@type", { link = "Type" })
  set("@type.builtin", { fg = syntax.type, bold = true })
  set("@string", { link = "String" })
  set("@string.escape", { fg = syntax.error })
  set("@number", { link = "Number" })
  set("@boolean", { link = "Boolean" })
  set("@constant", { link = "Constant" })
  set("@constant.builtin", { fg = syntax.constant, bold = true })
  set("@comment", { link = "Comment" })
  set("@punctuation", { fg = syntax.operator })
  set("@operator", { link = "Operator" })
  set("@tag", { fg = syntax.keyword })
  set("@tag.attribute", { fg = syntax.func, italic = true })
  set("@tag.delimiter", { fg = syntax.operator })
  set("@namespace", { fg = c.on_surface_variant })
  set("@field", { fg = syntax.ident })
  set("@property", { fg = c.on_surface_variant })

  if opts.integrations and opts.integrations.snacks then
    set("SnacksPickerDir", { fg = c.outline })
    set("SnacksPickerMatch", { fg = c.primary, bold = true })
    set("SnacksDashboardHeader", { fg = c.primary })
    set("SnacksDashboardKey", { fg = c.secondary, bold = true })
    set("SnacksDashboardDesc", { fg = c.on_surface })
    set("SnacksDashboardFooter", { fg = c.outline, italic = true })
  end

  if opts.integrations and opts.integrations.blink then
    set("BlinkCmpLabel", { fg = c.on_surface })
    set("BlinkCmpLabelMatch", { fg = c.primary, bold = true })
    set("BlinkCmpMenu", { fg = c.on_surface, bg = float_bg })
    set("BlinkCmpMenuBorder", { fg = c.outline, bg = float_bg })
    set("BlinkCmpMenuSelection", { fg = c.on_primary, bg = c.primary })
    set("BlinkCmpKind", { fg = c.secondary })
    set("BlinkCmpKindFunction", { fg = c.secondary })
    set("BlinkCmpKindMethod", { fg = c.secondary })
    set("BlinkCmpKindVariable", { fg = c.on_surface })
    set("BlinkCmpKindKeyword", { fg = c.primary })
  end

  set("GitSignsAdd", { fg = c.tertiary, bg = bg_main })
  set("GitSignsChange", { fg = c.secondary, bg = bg_main })
  set("GitSignsDelete", { fg = c.error, bg = bg_main })
  set("IblIndent", { fg = c.outline_variant })
  set("IblScope", { fg = c.outline })
  set("CmpItemAbbr", { fg = c.on_surface })
  set("CmpItemAbbrMatch", { fg = c.primary, bold = true })
  set("CmpItemKindFunction", { fg = syntax.func })
  set("CmpItemKindVariable", { fg = syntax.ident })
  set("CmpItemKindKeyword", { fg = syntax.keyword })
  set("WhichKey", { fg = syntax.keyword })
  set("WhichKeyDesc", { fg = syntax.ident })
  set("WhichKeyGroup", { fg = syntax.func, italic = true })
  set("WhichKeySeparator", { fg = c.outline })
  set("WhichKeyFloat", { bg = float_bg })
end

return M
