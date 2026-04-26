local M = {}

local fallback = {
  primary = "#cba6f7",
  on_primary = "#1e1e2e",
  primary_container = "#b4befe",
  on_primary_container = "#1e1e2e",
  secondary = "#89b4fa",
  on_secondary = "#1e1e2e",
  secondary_container = "#74c7ec",
  on_secondary_container = "#1e1e2e",
  tertiary = "#a6e3a1",
  on_tertiary = "#1e1e2e",
  tertiary_container = "#94e2d5",
  on_tertiary_container = "#1e1e2e",
  surface = "#313244",
  on_surface = "#cdd6f4",
  surface_variant = "#45475a",
  on_surface_variant = "#bac2de",
  background = "#1e1e2e",
  on_background = "#cdd6f4",
  error = "#f38ba8",
  on_error = "#1e1e2e",
  error_container = "#eba0ac",
  on_error_container = "#1e1e2e",
  outline = "#6c7086",
  outline_variant = "#45475a",
  inverse_primary = "#cba6f7",
  shadow = "#11111b",
  scrim = "#11111b",
  base00 = "#1e1e2e",
  base01 = "#313244",
  base02 = "#45475a",
  base03 = "#6c7086",
  base04 = "#7f849c",
  base05 = "#cdd6f4",
  base06 = "#bac2de",
  base07 = "#f5e0dc",
  base08 = "#f38ba8",
  base09 = "#fab387",
  base0a = "#f9e2af",
  base0b = "#a6e3a1",
  base0c = "#94e2d5",
  base0d = "#89b4fa",
  base0e = "#cba6f7",
  base0f = "#f2cdcd",
}

local function normalize_hex(value)
  if type(value) ~= "string" then
    return nil
  end
  if value:sub(1, 1) == "#" then
    return value
  end
  return "#" .. value
end

local function read_file(path)
  local expanded = vim.fn.expand(path)
  local ok, lines = pcall(vim.fn.readfile, expanded)
  if not ok or not lines then
    return nil
  end
  return table.concat(lines, "\n")
end

local function parse_json(raw)
  local ok, decoded = pcall(vim.json.decode, raw)
  if ok and type(decoded) == "table" then
    return decoded
  end
  return nil
end

function M.load(path)
  local raw = read_file(path)
  if not raw then
    return vim.deepcopy(fallback)
  end

  local decoded = parse_json(raw)
  if not decoded then
    return vim.deepcopy(fallback)
  end

  local colors = {}
  for key, value in pairs(fallback) do
    local found = normalize_hex(decoded[key])
    colors[key] = found or value
  end

  return colors
end

return M
