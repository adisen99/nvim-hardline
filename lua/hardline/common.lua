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
   n      = {'Normal', 'N', 'NormalMode'},
   no     = {'N·OpPd', '?', 'OpPending' },
   v      = {'Visual', 'V', 'VisualMode'},
   V      = {'V·Line', 'Vl', 'VisualLineMode'},
   [''] = {'V·Blck', 'Vb' },
   s      = {'Select', 'S' },
   S      = {'S·Line', 'Sl' },
   [''] = {'S·Block', 'Sb' },
   i      = {'Insert', 'I', 'InsertMode'},
   ic     = {'ICompl', 'Ic', 'ComplMode'},
   R      = {'Rplace', 'R', 'ReplaceMode'},
   Rv     = {'VRplce', 'Rv' },
   c      = {'Cmmand', 'C', 'CommandMode'},
   cv     = {'Vim Ex', 'E' },
   ce     = {'Ex (r)', 'E' },
   r      = {'Prompt', 'P' },
   rm     = {'More  ', 'M' },
   ['r?'] = {'Cnfirm', 'Cn'},
   ['!']  = {'Shell ', 'S'},
   t      = {'Term  ', 'T', 'TerminalMode'},
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
