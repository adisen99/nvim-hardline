local has_lsp_status, lsp_status = pcall(require, 'lsp-status')

local nvim_buf_get_var = function(bufnr, var_name)
  local ok, result = pcall(function()
    return vim.api.nvim_buf_get_var(bufnr, var_name)
  end)

  if ok then
    return result
  end
end

local helper = function(var_name)
  return function(_, buffer)
    return nvim_buf_get_var(buffer.bufnr, var_name)
  end
end

local get_current_function = helper('lsp_current_function')

local M = {}

M.segment = function(_, buffer)
  if not buffer.lsp or not has_lsp_status then
    return ''
  end

  local ok, result = pcall(lsp_status.status)
  return ok and result or ''
end

M.current_function = function(_, buffer)
  if not buffer.lsp or not has_lsp_status then
    return ''
  end

  local ok, current_func = pcall(get_current_function, _, buffer)
  if ok and current_func and #current_func > 0 then
    return string.format('[ %s ]', current_func)
  end

  return ''
end

M.server_progress = function(_, bufnr)
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
