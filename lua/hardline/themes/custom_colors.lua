-- Custom colorscheme

local M = {}

M.set = function(color_table)
  local inactive = {
    guifg = color_table.light_gray,
    guibg = color_table.black,
  }

  return {
    mode = {
      inactive = inactive,
      normal = {
        guifg = color_table.white,
        guibg = color_table.gray,
      },
      insert = {
        guifg = color_table.black,
        guibg = color_table.blue,
      },
      replace = {
        guifg = color_table.yellow,
        guibg = color_table.gray,
      },
      visual = {
        guifg = color_table.black,
        guibg = color_table.blue,
      },
      command = {
        guifg = color_table.red,
        guibg = color_table.gray,
      },
    },
    low = {
      active = {
        guifg = color_table.black,
        guibg = color_table.blue,
      },
      inactive = inactive,
    },
    med = {
      active = {
        guifg = color_table.black,
        guibg = color_table.blue,
      },
      inactive = {
        guifg = color_table.blue,
        guibg = color_table.black,
      },
    },
    high = {
      active = {
        guifg = color_table.black,
        guibg = color_table.blue,
      },
      inactive = inactive,
    },
    error = {
      active = {
        guifg = color_table.black,
        guibg = color_table.blue,
      },
      inactive = inactive,
    },
    warning = {
      active = {
        guifg = color_table.black,
        guibg = color_table.blue,
      },
      inactive = inactive,
    },
  }
end

return M
