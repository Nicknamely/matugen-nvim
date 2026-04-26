local config = require("matugen-nvim.config")

local M = {}

local function ensure_termguicolors()
  if not vim.opt.termguicolors:get() then
    vim.opt.termguicolors = true
  end
end

function M.setup()
  ensure_termguicolors()
  M.apply()

  local opts = config.get()
  if opts.watch then
    require("matugen-nvim.watcher").start(opts.palette_path, opts.watch_debounce_ms)
  end
end

function M.apply()
  local opts = config.get()
  local palette = require("matugen-nvim.palette").load(opts.palette_path)
  require("matugen-nvim.highlights").apply(palette, opts)

  if opts.integrations and opts.integrations.lualine then
    require("matugen-nvim.integrations.lualine").apply(palette)
  end

  vim.g.colors_name = "matugen-nvim"
end

function M.reload()
  require("matugen-nvim.watcher").stop()
  M.apply()
  local opts = config.get()
  if opts.watch then
    require("matugen-nvim.watcher").start(opts.palette_path, opts.watch_debounce_ms)
  end
end

function M.get_palette()
  local opts = config.get()
  return require("matugen-nvim.palette").load(opts.palette_path)
end

return M
