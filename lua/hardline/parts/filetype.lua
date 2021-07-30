local bo = vim.bo

local function get_file_info()
  return vim.fn.expand('%:t'), vim.fn.expand('%:e')
end

local function get_file_icon()
  local icon = ''
  if vim.fn.exists("*WebDevIconsGetFileTypeSymbol") == 1 then
    icon = vim.fn.WebDevIconsGetFileTypeSymbol()
    return icon .. ' '
  end
  local ok,devicons = pcall(require,'nvim-web-devicons')
  if not ok then print('No icon plugin found. Please install \'kyazdani42/nvim-web-devicons\'') return '' end
  local f_name,f_extension = get_file_info()
  icon = devicons.get_icon(f_name,f_extension)
  if icon == nil then
      icon = ''
  end
  return icon .. ' '
end

local function get_item()
  return get_file_icon .. bo.filetype
end

return {
  get_item = get_item,
}
