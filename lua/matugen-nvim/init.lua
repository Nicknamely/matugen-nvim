local config = require("matugen-nvim.config")

local M = {}

function M.setup(opts)
  config.setup(opts)
  require("matugen-nvim.main").setup()
end

function M.apply()
  require("matugen-nvim.main").apply()
end

function M.reload()
  require("matugen-nvim.main").reload()
end

function M.get_palette()
  return require("matugen-nvim.main").get_palette()
end

return M
