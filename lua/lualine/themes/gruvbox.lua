local C = require 'gruvbox'.colors()

return {
  normal = {
    a = { fg = C.bg0, bg = C.blue, bold = true },
    b = { fg = C.fg2, bg = C.bg2 },
    c = { fg = C.fg2, bg = C.bg1 },
  },
  insert = {
    a = { fg = C.bg0, bg = C.green, bold = true },
  },
  visual = {
    a = { fg = C.bg0, bg = C.purple, bold = true },
  },
  replace = {
    a = { fg = C.bg0, bg = C.red, bold = true },
  },
  command = {
    a = { fg = C.bg0, bg = C.yellow, bold = true },
  },
  inactive = {
    a = { fg = C.fg4, bg = C.bg2 },
    b = { fg = C.fg4, bg = C.bg2 },
    c = { fg = C.fg4, bg = C.bg1 },
  },
}
