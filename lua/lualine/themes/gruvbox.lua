local C = require'gruvbox'.colors()

return {
  normal = {
    a = { fg = C.bg0,  bg = C.blue_faded, bold = true },
    b = { fg = C.fg2,  bg = C.bg3 },
    c = { fg = C.fg3,  bg = C.bg2 },
  },
  insert = {
    a = { fg = C.bg0,  bg = C.green_faded, bold = true },
  },
  visual = {
    a = { fg = C.bg0,  bg = C.purple_faded, bold = true },
  },
  replace = {
    a = { fg = C.bg0,  bg = C.red_faded, bold = true },
  },
  command = {
    a = { fg = C.bg0,  bg = C.yellow_faded, bold = true },
  },
  inactive = {
    a = { fg = C.fg3,  bg = C.bg3 },
    b = { fg = C.fg4,  bg = C.bg2 },
    c = { fg = C.gray, bg = C.bg1 },
  },
}

