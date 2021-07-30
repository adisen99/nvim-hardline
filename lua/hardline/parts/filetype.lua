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

local function get_filetype()
  return bo.filetype
end

local function get_item()
 local icon = get_file_icon()
 local ft = get_filetype()
 return table.concat({icon, ft})
end

return {
  get_item = get_item,
}
