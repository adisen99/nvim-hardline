local cmd, fn = vim.cmd, vim.fn
local g = vim.g
local fmt = string.format
local M = {}

-- old modes code
--[[ M.modes = {
  ['?'] = {text = '???', state = 'inactive'},
  ['n'] = {text = 'NORMAL', state = 'normal'},
  ['i'] = {text = 'INSERT', state = 'insert'},
  ['R'] = {text = 'REPLACE', state = 'replace'},
  ['v'] = {text = 'VISUAL', state = 'visual'},
  ['V'] = {text = 'V-LINE', state = 'visual'},
  [''] = {text = 'V-BLOCK', state = 'visual'},
  ['c'] = {text = 'COMMAND', state = 'command'},
  ['s'] = {text = 'SELECT', state = 'visual'},
  ['S'] = {text = 'S-LINE', state = 'visual'},
  [''] = {text = 'S-BLOCK', state = 'visual'},
  ['t'] = {text = 'TERMINAL', state = 'command'},
} ]]

-- new modes
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
  cmd(fmt('echohl %s', hlgroup))
  cmd(fmt('echo "[hardline] %s"', msg))
  cmd('echohl None')
end

function M.is_active()
  return g.statusline_winid == fn.win_getid()
end

function M.set_cache_autocmds(augroup)
  cmd(fmt('augroup %s', augroup))
  cmd('autocmd!')
  cmd(fmt('autocmd CursorHold,BufWritePost * unlet! b:%s', augroup))
  cmd('augroup END')
end

return M
