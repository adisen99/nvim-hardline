local has_lsp_status, lsp_status = pcall(require, 'lsp-status')

local M = {}

M.get_item = function(_, bufnr)
  if vim.inspect(vim.lsp.buf_get_clients()) == {} or not has_lsp_status then
    return ''
  end

  local buffer_clients = vim.lsp.buf_get_clients(bufnr)
  local buffer_client_set = {}
  for _, v in pairs(buffer_clients) do
    buffer_client_set[v.name] = true
  end

  local all_messages = lsp_status.messages()

  for _, msg in ipairs(all_messages) do
    if msg.name and buffer_client_set[msg.name] then
      local contents = ''
      if msg.progress then
        contents = msg.title
        if msg.message then
          contents = contents .. ' ' .. msg.message
        end

        if msg.percentage then
          contents = contents .. ' (' .. msg.percentage .. ')'
        end

      elseif msg.status then
        contents = msg.content
      else
        contents = msg.content
      end

      return ' ' .. contents .. ' '
    end
  end

  return ''
end

return M
