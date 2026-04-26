local config = require("matugen-nvim.config")

local M = {}

local function build_theme(c)
  return {
    normal = {
      a = { fg = c.on_primary, bg = c.primary, gui = "bold" },
      b = { fg = c.on_surface, bg = c.surface },
      c = { fg = c.outline, bg = "NONE" },
    },
    insert = {
      a = { fg = c.on_secondary, bg = c.secondary, gui = "bold" },
      b = { fg = c.on_surface, bg = c.surface },
      c = { fg = c.outline, bg = "NONE" },
    },
    visual = {
      a = { fg = c.on_primary, bg = c.tertiary, gui = "bold" },
      b = { fg = c.on_surface, bg = c.surface },
      c = { fg = c.outline, bg = "NONE" },
    },
    replace = {
      a = { fg = c.on_error, bg = c.error, gui = "bold" },
      b = { fg = c.on_surface, bg = c.surface },
      c = { fg = c.outline, bg = "NONE" },
    },
    command = {
      a = { fg = c.on_primary, bg = c.outline, gui = "bold" },
      b = { fg = c.on_surface, bg = c.surface },
      c = { fg = c.outline, bg = "NONE" },
    },
    inactive = {
      a = { fg = c.outline, bg = "NONE" },
      b = { fg = c.outline, bg = "NONE" },
      c = { fg = c.outline, bg = "NONE" },
    },
  }
end

function M.get()
  local opts = config.get()
  local palette = require("matugen-nvim.palette").load(opts.palette_path)
  return build_theme(palette)
end

function M.refresh()
  if not package.loaded.lualine then
    return
  end

  local ok, lualine = pcall(require, "lualine")
  if not ok then
    return
  end

  local current = lualine.get_config() or {}
  current.options = current.options or {}
  current.options.theme = M.get()

  lualine.setup(current)
  lualine.refresh()
end

return M
