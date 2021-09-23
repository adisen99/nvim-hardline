-- Custom color_tablecheme

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
      guifg = color_table.black,
      guibg = color_table.blue,
    },
    insert = {
      guifg = color_table.black,
      guibg = color_table.green,
    },
    replace = {
      guifg = color_table.gray,
      guibg = color_table.aqua,
    },
    visual = {
      guifg = color_table.black,
      guibg = color_table.purple,
    },
    command = {
      guifg = color_table.black,
      guibg = color_table.red,
    },
  },
    mode_cool = {
      inactive = inactive,
      normal = {
        guifg = color_table.white,
        guibg = color_table.gray,
      },
      insert = {
        guifg = color_table.black,
        guibg = color_table.cool,
      },
      replace = {
        guifg = color_table.yellow,
        guibg = color_table.gray,
      },
      visual = {
        guifg = color_table.black,
        guibg = color_table.cool,
      },
      command = {
        guifg = color_table.red,
        guibg = color_table.gray,
      },
    },
    low = {
      active = {
        guifg = color_table.white,
        guibg = color_table.gray,
      },
      inactive = inactive,
    },
    med = {
      active = {
        guifg = color_table.yellow,
        guibg = color_table.grey,
      },
      inactive = inactive,
    },
    high = {
      active = {
        guifg = color_table.white,
        guibg = color_table.light_gray,
      },
      inactive = inactive,
    },
    cool = {
        guifg = color_table.black,
        guibg = color_table.cool,
      },
      inactive = {
        guifg = color_table.cool,
        guibg = color_table.black,
    },
    error = {
      active = {
        guifg = color_table.black,
        guibg = color_table.red,
      },
      inactive = inactive,
    },
    warning = {
      active = {
        guifg = color_table.black,
        guibg = color_table.yellow,
      },
      inactive = inactive,
    },
  }
end

return M
