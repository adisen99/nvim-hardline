local fmt = string.format
local M = {}

M.modes = {
   ['?']      = {text = '???', state = 'inactive'},
   n      = {text = 'Normal', state = 'normal'},
   no     = {text = 'N·OpPd', state = 'normal'},
   v      = {text = 'Visual', state = 'visual'},
   V      = {text = 'V·Line', state = 'visual'},
   ['']     = {text = 'V·Blck', state = 'visual'},
   s      = {text = 'Select', state = 'visual'},
   S      = {text = 'S·Line', state = 'visual'},
   ['']     = {text = 'S·Block', state = 'visual'},
   i      = {text = 'Insert', state = 'insert'},
   ic     = {text = 'ICompl', state = 'insert'},
   R      = {text = 'Rplace', state = 'replace'},
   Rv     = {text = 'VRplce', state = 'replace'},
   c      = {text = 'Cmmand', state = 'command'},
   cv     = {text = 'Vim Ex', state = 'normal'},
   ce     = {text = 'Ex (r)', state = 'normal'},
   r      = {text = 'Prompt', state = 'command'},
   rm     = {text = 'More  ', state = 'command'},
   ['r?']     = {text = 'Cnfirm', state = 'insert'},
   ['!']      = {text = 'Shell ', state = 'normal'},
   t      = {text = 'Term  ', state = 'normal'},
}

function M.echo(hlgroup, msg)
  vim.api.nvim_echo({{fmt('[hardline] %s', msg), hlgroup}}, false, {})
end

function M.set_cache_autocmds(augroup)
  vim.cmd(fmt([[
  augroup %s
    autocmd!
    autocmd CursorHold,BufWritePost * unlet! b:%s
  augroup END
  ]], augroup, augroup))
end

return M
