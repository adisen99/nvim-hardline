local bo = vim.bo

local function get_filetype()
  return bo.filetype
end

local function get_item()
 local ft = get_filetype()
 return ft
end

return {
  get_item = get_item,
}
