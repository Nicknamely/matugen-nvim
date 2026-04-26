local M = {}

M.defaults = {
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

M.options = nil

function M.setup(opts)
  local merged = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
  M.options = merged
  return merged
end

function M.get()
  if not M.options then
    return M.setup({})
  end
  return M.options
end

return M
