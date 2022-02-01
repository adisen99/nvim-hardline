-- nvim-hardline
-- By Olivier Roques
-- github.com/ojroques

-------------------- VARIABLES -----------------------------

local fn, cmd, vim = vim.fn, vim.cmd, vim
local g, o, wo = vim.g, vim.o, vim.wo
local fmt = string.format
local common = require('hardline.common')
local set_colors = require('hardline.themes.set_colors')
local M = {}

-------------------- OPTIONS -------------------------------

local colors = {
    white = "#fbfbfb",
    light_gray = '#555e61',
    gray = "#2e373b",
    black = "#182227",
    blue = '#94aadb',
    red = "#dda790",
    aqua = "#b5d8f6",
    green = "#8bb664",
    yellow = "#e9c062",
    purple = "#bfabcb",
    cool = '#94aadb'
}

M.options = {
  theme = colors,
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
    {class = 'med', item = require('hardline.parts.filename').get_item},
    '%<',
    {class = 'med', item = '%='},
    {class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 100},
    {class = 'low', item = require('hardline.parts.server_progress').get_item, hide=80},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 80},
    {class = 'high', item = require('hardline.parts.line').get_item},
  },
}

-------------------- SECTION MANAGEMENT --------------------

local function aggregate_sections(sections)
  local aggregated, piv = {}, 1
  while piv <= #sections do
    if type(sections[piv]) == 'table' then
      local items = {}
      for j = piv, #sections + 1 do
        if j == #sections + 1 or sections[j].class ~= sections[piv].class then
          table.insert(aggregated, {
            class = sections[piv].class,
            item = fmt(' %s ', table.concat(items, ' ')),
          })
          piv = j
          break
        end
        table.insert(items, sections[j].item)
      end
    else
      table.insert(aggregated, sections[piv])
      piv = piv + 1
    end
  end
  return aggregated
end

local function remove_empty_sections(sections)
  local filter = function(section)
    if type(section) == 'table' then
      return section.item ~= ''
    end
    return section ~= ''
  end
  return vim.tbl_filter(filter, sections)
end

local function load_sections(sections)
  function load_section(section)
    if type(section) == 'string' then
      return section
    end
    if type(section) == 'function' then
      return section()
    end
    if type(section) == 'table' then
      return {
        class = section.class or 'none',
        item = load_section(section.item),
      }
    end
    common.echo('WarningMsg', 'Invalid section.')
    return ''
  end
  return vim.tbl_map(load_section, sections)
end

local function remove_hidden_sections(sections)
  local filter = function(section)
    return not section.hide or section.hide <= fn.winwidth(0)
  end
  return vim.tbl_filter(filter, sections)
end

-------------------- SECTION HIGHLIGHTING ------------------
local function get_section_state(section, is_active)
  if section.class == 'mode' or section.class == 'mode_cool' then
    if is_active then
      local mode = common.modes[fn.mode()] or common.modes['?']
      return mode.state
    end
  end
  return is_active and 'active' or 'inactive'
end

local function highlight_sections(sections, is_active)
  function highlight_section(section)
    if type(section) ~= 'table' then
      return section
    end
    if section.class == 'none' then
      return section.item
    end
    local state = get_section_state(section, is_active)
    local hlgroup = fmt('Hardline_%s_%s', section.class, state)
    if fn.hlexists(hlgroup) == 0 then
      return section.item
    end
    return fmt('%%#%s#%s%%*', hlgroup, section.item)
  end
  return vim.tbl_map(highlight_section, sections)
end

-------------------- STATUSLINE ----------------------------
function M.update_statusline(is_active)
  local sections = M.options.sections
  sections = remove_hidden_sections(sections)
  sections = load_sections(sections)
  sections = remove_empty_sections(sections)
  sections = aggregate_sections(sections)
  sections = highlight_sections(sections, is_active)
  return table.concat(sections)
end

-------------------- SETUP -----------------------------
local function set_theme()
  if type(M.options.theme) ~= 'table' then
    return
  end
  M.options.theme = set_colors.set(M.options.theme)
end

local function set_hlgroups()
  for class, attr in pairs(M.options.theme) do
    for state, args in pairs(attr) do
      local hlgroup = fmt('Hardline_%s_%s', class, state)
      local a = {}
      for k, v in pairs(args) do
        table.insert(a, fmt('%s=%s', k, v))
      end
      a = table.concat(a, ' ')
      cmd(fmt('autocmd VimEnter,ColorScheme * hi %s %s', hlgroup, a))
    end
  end
end

local function set_statusline()
  o.showmode = false
  o.statusline = [[%!luaeval('require("hardline").update_statusline(false)')]]
  vim.cmd([[
  augroup hardline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%{%luaeval('require(\"hardline\").update_statusline(true)')%}
    autocmd WinLeave,BufLeave * setlocal statusline=%{%luaeval('require(\"hardline\").update_statusline(false)')%}
  augroup END
  ]])
end

function M.setup(user_options)
  if user_options then
    M.options = vim.tbl_extend('force', M.options, user_options)
  end
  set_theme()
  set_hlgroups()
  set_statusline()
end

------------------------------------------------------------
return M
