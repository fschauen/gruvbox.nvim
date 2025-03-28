local M = {}

local to_hex = function(s)
  local r, g, b = string.match(s, "^rgb%(%s*(%d+),%s*(%d+),%s*(%d+)%)")
  return string.format("#%02x%02x%02x", r, g, b)
end

M.colors = function()
  local c = {
    dark0_h         = to_hex("rgb( 19,  21,  22)"),
    dark0           = to_hex("rgb( 24,  25,  26)"),
    dark0_s         = to_hex("rgb( 29,  32,  33)"),  -- bg0_h
    --                to_hex("rgb( 40,  40,  40)"),  -- bg0
    --                to_hex("rgb( 50,  48,  47)"),  -- bg0_s
    dark1           = to_hex("rgb( 60,  56,  54)"),
    dark2           = to_hex("rgb( 80,  73,  69)"),
    dark3           = to_hex("rgb(102,  92,  84)"),
    dark4           = to_hex("rgb(124, 111, 100)"),
    gray            = to_hex("rgb(146, 131, 116)"),
    light4          = to_hex("rgb(168, 153, 132)"),
    light3          = to_hex("rgb(189, 174, 147)"),
    light2          = to_hex("rgb(213, 196, 161)"),
    light1          = to_hex("rgb(235, 219, 178)"),
    light0_s        = to_hex("rgb(242, 229, 188)"),
    light0          = to_hex("rgb(251, 241, 199)"),
    light0_h        = to_hex("rgb(249, 245, 215)"),

    red_darkest     = to_hex("rgb( 46,  16,  15)"),
    green_darkest   = to_hex("rgb( 46,  46,  15)"),
    yellow_darkest  = to_hex("rgb( 46,  36,  15)"),
    blue_darkest    = to_hex("rgb( 20,  40,  41)"),
    purple_darkest  = to_hex("rgb( 41,  20,  30)"),
    aqua_darkest    = to_hex("rgb( 24,  37,  25)"),
    orange_darkest  = to_hex("rgb( 50,  26,  11)"),

    red_darker      = to_hex("rgb(157,   0,   6)"),
    green_darker    = to_hex("rgb(121, 116,  14)"),
    yellow_darker   = to_hex("rgb(181, 118,  20)"),
    blue_darker     = to_hex("rgb(  7, 102, 120)"),
    purple_darker   = to_hex("rgb(143,  63, 113)"),
    aqua_darker     = to_hex("rgb( 66, 123,  88)"),
    orange_darker   = to_hex("rgb(175,  58,   3)"),

    red             = to_hex("rgb(204,  36,  29)"),
    green           = to_hex("rgb(152, 151,  26)"),
    yellow          = to_hex("rgb(215, 153,  33)"),
    blue            = to_hex("rgb( 69, 133, 136)"),
    purple          = to_hex("rgb(177,  98, 134)"),
    aqua            = to_hex("rgb(104, 157, 106)"),
    orange          = to_hex("rgb(214,  93,  14)"),

    red_lighter     = to_hex("rgb(251,  73,  52)"),
    green_lighter   = to_hex("rgb(184, 187,  38)"),
    yellow_lighter  = to_hex("rgb(250, 189,  47)"),
    blue_lighter    = to_hex("rgb(131, 165, 152)"),
    purple_lighter  = to_hex("rgb(211, 134, 155)"),
    aqua_lighter    = to_hex("rgb(142, 192, 124)"),
    orange_lighter  = to_hex("rgb(254, 128,  25)"),

    red_lightest    = to_hex("rgb(255, 215, 212)"),
    green_lightest  = to_hex("rgb(238, 238, 210)"),
    yellow_lightest = to_hex("rgb(243, 234, 206)"),
    blue_lightest   = to_hex("rgb(210, 228, 229)"),
    purple_lightest = to_hex("rgb(242, 222, 231)"),
    aqua_lightest   = to_hex("rgb(212, 227, 212)"),
    orange_lightest = to_hex("rgb(243, 224, 211)"),
  }

  local is_dark = vim.opt.background:get() == 'dark'
  local palette = { gray = c.gray }

  for i = 0, 4, 1 do
    palette['fg' .. tostring(i)] = c[(is_dark and 'light' or 'dark') .. tostring(i)]
    palette['bg' .. tostring(i)] = c[(is_dark and 'dark' or 'light') .. tostring(i)]
  end

  palette['fg0_h'] = c[(is_dark and 'light' or 'dark') .. '0_h']
  palette['fg0_s'] = c[(is_dark and 'light' or 'dark') .. '0_s']
  palette['bg0_h'] = c[(is_dark and 'dark' or 'light') .. '0_h']
  palette['bg0_s'] = c[(is_dark and 'dark' or 'light') .. '0_s']

  for _, accent in ipairs({'red', 'green', 'yellow', 'blue', 'purple', 'aqua', 'orange'}) do
    palette[accent] = c[accent]
    palette['dim_' .. accent] = c[accent .. '_' .. (is_dark and 'darker' or 'lighter')]
    palette['br_' .. accent] = c[accent .. '_' .. (is_dark and 'lighter' or 'darker')]
    palette[accent .. '_bg'] = c[accent .. '_' .. (is_dark and 'darkest' or 'lightest')]
  end

  return palette
end

M.highlights = function()
  local C = M.colors()
  local fg = C.fg3
  local bg = C.bg0_h

  return {
    standard = {
      Normal         = { fg = fg, bg = bg },   -- normal text
      NormalNC       = { fg = fg, bg = C.bg0 },    -- normal text in non-current windows

      NormalFloat    = { link = 'Normal' },    -- floating windows
      FloatBorder    = { fg = C.gray, bg = bg },
      FloatTitle     = { fg = C.blue },

      Comment        = { fg = C.bg3, italic = false },  -- any comment

      Constant       = { fg   = C.orange },  -- any constant
      String         = { fg   = C.aqua   },  -- a string constant: "this is a string"
      Character      = { link = 'String' },  -- a character constant: 'c', '\n'
      Number         = { link = 'String' },  -- a number constant: 234, 0xff
      Boolean        = { fg = C.aqua, bold = true, italic = true },  -- a boolean constant: TRUE, false
      Float          = { link = 'String' },  -- a floating point constant: 2.3e10

      Identifier     = { fg   = fg },
      Function       = { fg   = C.blue },

      Statement      = { fg   = C.green    },   -- any statement
      Conditional    = { link = 'Statement' },  -- if, then, else, endif, switch, etc.
      Repeat         = { link = 'Statement' },  -- for, do, while, etc.
      Label          = { link = 'Statement' },  -- case, default, etc.
      Operator       = { link = 'Statement' },  -- "sizeof", "+", "*", etc.
      Keyword        = { link = 'Statement' },  -- any other keyword
      Exception      = { link = 'Statement' },  -- try, catch, throw

      PreProc        = { fg   = C.dim_orange }, -- generic Preprocessor
      Include        = { link = 'PreProc' },    -- preprocessor #include
      Define         = { link = 'PreProc' },    -- preprocessor #define
      Macro          = { link = 'Constant' },   -- same as Define
      PreCondit      = { link = 'PreProc' },    -- preprocessor #if, #else, #endif, etc.

      Type           = { fg   = C.yellow },     -- int, long, char, etc.
      StorageClass   = { link = 'Statement' },  -- static, register, volatile, etc.
      Structure      = { link = 'Statement' },  -- struct, union, enum, etc.
      Typedef        = { link = 'Statement' },  -- A typedef

      Special        = { fg   = C.dim_orange }, -- any special symbol
      SpecialChar    = { link = 'Special' },    -- special character in a constant
      Tag            = { link = 'Special' },    -- you can use CTRL-] on this
      Delimiter      = { link = 'Special' },    -- character that needs attention
      SpecialComment = { link = 'Special' },    -- special things inside a comment
      Debug          = { link = 'Special' },    -- debugging statements

      Underlined     = { underline = true },
      Ignore         = { },
      Todo           = { fg = C.purple, bold = true },
      Error          = { fg = C.red },
      Warning        = { fg = C.yellow},
      Information    = { fg = C.blue },
      Hint           = { fg = C.fg4 },
    },

    additional = {
      StatusLine     = { fg = fg , bg = C.bg2, reverse = true},
      StatusLineNC   = { fg = C.bg4, bg = C.bg2, reverse = true},
      Visual         = { fg = C.bg3, bg = bg,       reverse = true},

      SpecialKey     = { fg = C.bg4, bg =C.bg2, bold = true },
      SignColumn     = { fg = C.fg4 },
      Conceal        = { fg = C.blue },
      Cursor         = { fg = bg, bg = C.fg4 },
      TermCursorNC   = { fg = bg, bg = C.bg3 },
      lCursor        = { link = 'Cursor' },
      TermCursor     = { link = 'Cursor' },

      LineNr         = { fg = C.bg3 },
      CursorLine     = { bg = C.bg0 },
      CursorLineNr   = { bg = C.bg0, fg = C.fg2 },

      IncSearch      = { link = 'CurSearch' },
      CurSearch      = { fg = C.purple_bg, bg = C.br_purple, bold = true },
      Search         = { fg = C.br_purple, bg = C.purple_bg },

      DiffAdd        = { fg = C.green, bg = C.green_bg },
      DiffDelete     = { fg = C.red, bg = C.red_bg },
      DiffChange     = { fg = C.yellow, bg = C.yellow_bg },
      DiffText       = { fg = C.orange, bg = C.orange_bg },
      diffFile       = { fg = C.br_blue, bg = C.blue_bg },
      diffIndexLine  = { fg = C.blue },
      diffNewFile    = { link = 'diffIndexLine' },
      diffOldFile    = { link = 'diffIndexLine' },
      diffLine       = { fg = C.purple },
      diffSubname    = { link = 'diffLine' },
      diffAdded      = { link = 'DiffAdd' },
      diffRemoved    = { link = 'DiffDelete' },

      SpellBad       = { fg = C.orange, undercurl = true },
      SpellCap       = { undercurl = true },
      SpellRare      = { undercurl = true },
      SpellLocal     = { undercurl = true },

      ErrorMsg       = { link = 'Error' },
      MoreMsg        = { fg = C.fg2 },
      ModeMsg        = { fg = C.blue },
      Question       = { link = 'MoreMsg' },
      VertSplit      = { fg = C.bg4 },
      Title          = { fg = C.yellow, bold = true },
      SubTitle       = { fg = C.yellow, bold = false },
      VisualNOS      = { bg = C.bg2, reverse = true },
      WarningMsg     = { link = 'Warning' },
      WildMenu       = { fg = C.fg2, bg = C.bg2 },
      Folded         = { fg = C.blue, bg = bg },
      FoldColumn     = { fg = C.blue, bg = bg },

      Directory      = { fg = C.blue },

      NonText        = { fg = C.bg3 },                   -- subtle EOL symbols
      Whitespace     = { fg = C.orange },                -- listchars
      QuickFixLine   = { fg = C.yellow , bg = C.bg2 },   -- selected quickfix item

      TabLine     = { fg = C.fg4, bg = C.bg1, underline = true },
      TabLineFill = { fg = C.fg4, bg = C.bg1, underline = true },
      TabLineSel  = { fg = C.blue, bg = bg },

      MatchParen  = { fg = C.red, bg = C.red_bg, bold = true },
    },

    diagnostic = {
      DiagnosticOk    = { fg = C.green },
      DiagnosticWarn  = { link = 'Warning' },
      DiagnosticError = { link = 'Error' },
      DiagnosticInfo  = { link = 'Information' },
      DiagnosticHint  = { link = 'Hint' },

      DiagnosticVirtualTextWarn  = { fg = C.dim_yellow },
      DiagnosticVirtualTextError = { fg = C.dim_red },
      DiagnosticVirtualTextInfo  = { fg = C.dim_blue },
      DiagnosticVirtualTextHint  = { fg = C.gray },

      DiagnosticSignWarn  = { link = 'DiagnosticVirtualTextWarn' },
      DiagnosticSignError = { link = 'DiagnosticVirtualTextError' },
      DiagnosticSignInfo  = { link = 'DiagnosticVirtualTextInfo' },
      DiagnosticSignHint  = { link = 'DiagnosticVirtualTextHint' },
    },

    pum = {
      Pmenu       = { fg = fg, bg = C.bg2 },                    -- popup menu normal item
      PmenuSel    = { fg = C.bg3, bg = C.fg2, reverse = true},  -- selected item
      PmenuSbar   = { fg = C.bg2, reverse = true },
      PmenuThumb  = { fg = C.fg4, reverse = true },
    },

    vim = {
      vimVar             = { link = 'Identifier' },
      vimFunc            = { link = 'Identifier' },
      vimUserFunc        = { link = 'Identifier' },
      helpSpecial        = { link = 'Special' },
      vimSet             = { link = 'Normal' },
      vimSetEqual        = { link = 'Normal' },
      vimCommentString   = { fg = C.purple },
      vimCommand         = { fg = C.yellow },
      vimCmdSep          = { fg = C.blue, bold = true },
      helpExample        = { fg = fg },
      helpOption         = { fg = C.aqua },
      helpNote           = { fg = C.purple },
      helpVim            = { fg = C.purple },
      helpHyperTextJump  = { fg = C.blue, underline = true },
      helpHyperTextEntry = { fg = C.green },
      vimIsCommand       = { fg = C.bg4 },
      vimSynMtchOpt      = { fg = C.yellow },
      vimSynType         = { fg = C.aqua },
      vimHiLink          = { fg = C.blue },
      vimGroup           = { fg = C.blue, underline = true, bold = true},
    },

    gitcommit = {
      gitcommitSummary         = { fg = C.green },
      gitcommitComment         = { link = 'Comment' },
      gitcommitUntracked       = { link = 'gitcommitComment' },
      gitcommitDiscarded       = { link = 'gitcommitComment' },
      gitcommitSelected        = { link = 'gitcommitComment' },
      gitcommitOnBranch        = { link = 'gitcommitComment' },

      gitcommitBranch          = { fg = C.br_blue, bg = C.blue_bg },
      gitcommitNoBranch        = { link = 'gitcommitBranch' },

      gitcommitHeader          = { fg = C.bg4 },
      gitcommitFile            = { link = 'gitcommitHeader' },

      gitcommitSelectedType    = { fg = C.green },
      gitcommitSelectedFile    = { link = 'gitcommitSelectedType' },
      gitcommitSelectedArrow   = { link = 'gitCommitSelectedFile' },

      gitcommitDiscardedType   = { fg = C.orange },
      gitcommitDiscardedFile   = { link = 'gitcommitDiscardedType' },
      gitcommitDiscardedArrow  = { link = 'gitCommitDiscardedFile' },

      gitcommitUntrackedFile   = { fg = C.aqua },

      gitcommitUnmerged        = { fg = C.yellow },
      gitcommitUnmergedFile    = { fg = C.red },
      gitcommitUnmergedArrow   = { link = 'gitCommitUnmergedFile' },
    },

    markdown = {
      markdownH1                  = { link = 'Title' },
      markdownH2                  = { link = 'Title' },
      markdownH3                  = { link = 'Subtitle' },
      markdownH4                  = { link = 'Subtitle' },
      markdownH5                  = { link = 'Subtitle' },
      markdownH6                  = { link = 'Subtitle' },
      markdownHeadingRule         = { fg = C.yellow, bold = true },
      markdownHeadingDelimiter    = { link = 'markdownHeadingRule' },
      markdownH1Delimiter         = { link = 'markdownHeadingDelimiter' },
      markdownH2Delimiter         = { link = 'markdownHeadingDelimiter' },
      markdownH3Delimiter         = { link = 'markdownHeadingDelimiter' },
      markdownH4Delimiter         = { link = 'markdownHeadingDelimiter' },
      markdownH5Delimiter         = { link = 'markdownHeadingDelimiter' },
      markdownH6Delimiter         = { link = 'markdownHeadingDelimiter' },

      markdownListMarker          = { fg = C.fg2 },
      markdownOrderedListMarker   = { link = 'markdownListMarker' },
      markdownBlockquote          = { fg = C.fg2, bold = true, italic = true },
      markdownRule                = { link = 'Comment' },

      markdownItalic              = { fg = fg, italic = true },
      markdownBold                = { fg = fg, bold = true },
      markdownBoldItalic          = { fg = fg, bold = true, italic = true },
      markdownCode                = { fg = C.orange },
      markdownCodeBlock           = { link = 'markdownCode' },
      markdownItalicDelimiter     = { link = 'Comment' },
      markdownBoldDelimiter       = { link = 'Comment' },
      markdownBoldItalicDelimiter = { link = 'Comment' },
      markdownCodeDelimiter       = { link = 'Comment' },

      markdownFootnote            = { fg = C.aqua },
      markdownFootnoteDefinition  = { link = 'markdownFootnote' },

      markdownLinkText            = { fg = C.blue },
      markdownId                  = { link = 'Comment' },
      markdownUrl                 = { link = 'Comment' },
      markdownUrlTitle            = { fg = C.aqua },

      markdownLinkTextDelimiter   = { link = 'Comment' },
      markdownIdDelimiter         = { link = 'Comment' },
      markdownLinkDelimiter       = { link = 'Comment' },
      markdownUrlTitleDelimiter   = { link = 'Comment' },
      markdownIdDeclaration       = { link = 'markdownLinkText' },

      markdownEscape              = { link = 'Special' },
      markdownError               = { link = 'Error' },
    },

    treesitter = {
      TSAnnotation          = { link = 'PreProc' },
      TSAttribute           = { link = 'PreProc' },
      TSBoolean             = { link = 'Boolean' },
      TSCharacter           = { link = 'Character' },
      TSCharacterSpecial    = { link = 'Special' },
      TSComment             = { link = 'Comment' },
      TSConditional         = { link = 'Conditional' },
      TSConstant            = { link = 'Constant' },
      TSConstBuiltin        = { link = 'Constant' },
      TSConstMacro          = { link = 'Define' },
      TSConstructor         = { fg = C.yellow },
      TSDebug               = { link = 'Debug' },
      TSDefine              = { link = 'Define' },
      TSError               = { link = 'Error' },
      TSException           = { link = 'Exception' },
      TSField               = { link = 'Identifier' },
      TSFloat               = { link = 'Float' },
      TSFunction            = { link = 'Function' },
      TSFunctionCall        = { link = 'Function' },
      TSFuncBuiltin         = { link = 'Function' },
      TSFuncMacro           = { link = 'Macro' },
      TSInclude             = { link = 'Include' },
      TSKeyword             = { link = 'Keyword' },
      TSKeywordFunction     = { link = 'Keyword' },
      TSKeywordOperator     = { link = 'Keyword' },
      TSKeywordReturn       = { link = 'Keyword' },
      TSLabel               = { link = 'Label' },
      TSMethod              = { link = 'TSFunction' },
      TSMethodCall          = { link = 'TSFunctionCall' },
      TSNamespace           = { link = 'Include' },
      TSNone                = { },
      TSNumber              = { link = 'Number' },
      TSOperator            = { fg = C.fg2 },
      TSParameter           = { link = 'Identifier' },
      TSParameterReference  = { link = 'TSParameter' },
      TSPreProc             = { link = 'PreProc' },
      TSProperty            = { link = 'Identifier' },
      TSPunctDelimiter      = { fg = C.bg3 },
      TSPunctBracket        = { link = 'Normal' },
      TSPunctSpecial        = { link = 'TSOperator' },
      TSRepeat              = { link = 'Repeat' },
      TSStorageClass        = { link = 'StorageClass' },
      TSString              = { link = 'String' },
      TSStringRegex         = { link = 'String' },
      TSStringEscape        = { link = 'SpecialChar' },
      TSStringSpecial       = { link = 'SpecialChar' },
      TSSymbol              = { link = 'Identifier' },
      TSTag                 = { link = 'Label' },
      TSTagAttribute        = { link = 'TSProperty' },
      TSTagDelimiter        = { link = 'Delimiter' },
      TSText                = { link = 'TSNone' },
      TSStrong              = { fg = fg, bold = true },
      TSEmphasis            = { fg = fg, italic = true },
      TSUnderline           = { underline = true },
      TSStrike              = { strikethrough = true },
      TSTitle               = { link = 'Title' },
      TSLiteral             = { link = 'markdownCode' },
      TSURI                 = { link = 'markdownUrl' },
      TSMath                = { link = 'Special' },
      TSTextReference       = { link = 'markdownLinkText' },
      TSEnvironment         = { link = 'Macro' },
      TSEnvironmentName     = { link = 'Constant' },
      TSNote                = { link = 'SpecialComment' },
      TSWarning             = { link = 'Todo' },
      TSDanger              = { link = 'WarningMsg' },
      TSTodo                = { link = 'Todo' },
      TSType                = { link = 'Type' },
      TSTypeBuiltin         = { link = 'Type' },
      TSTypeQualifier       = { },
      TSTypeDefinition      = { },
      TSVariable            = { link = 'Identifier' },
      TSVariableBuiltin     = { link = 'Identifier' },
      ['@comment']                  = { link = 'Comment' },
      ['@none']                     = { bg   = 'NONE', fg = 'NONE' },
      ['@preproc']                  = { link = 'PreProc' },
      ['@define']                   = { link = 'Define' },
      ['@operator']                 = { link = 'Operator' },
      ['@punctuation.delimiter']    = { link = 'Delimiter' },
      ['@punctuation.bracket']      = { link = 'Delimiter' },
      ['@punctuation.special']      = { link = 'Delimiter' },
      ['@string']                   = { link = 'String' },
      ['@string.regex']             = { link = 'String' },
      ['@string.regexp']            = { link = 'String' },
      ['@string.escape']            = { link = 'SpecialChar' },
      ['@string.special']           = { link = 'SpecialChar' },
      ['@string.special.path']      = { link = 'Underlined' },
      ['@string.special.symbol']    = { link = 'Identifier' },
      ['@string.special.url']       = { link = 'Underlined' },
      ['@character']                = { link = 'Character' },
      ['@character.special']        = { link = 'SpecialChar' },
      ['@boolean']                  = { link = 'Boolean' },
      ['@number']                   = { link = 'Number' },
      ['@number.float']             = { link = 'Float' },
      ['@float']                    = { link = 'Float' },
      ['@function']                 = { link = 'Function' },
      ['@function.builtin']         = { link = 'Special' },
      ['@function.call']            = { link = 'Function' },
      ['@function.macro']           = { link = 'Macro' },
      ['@function.method']          = { link = 'Function' },
      ['@method']                   = { link = 'Function' },
      ['@method.call']              = { link = 'Function' },
      ['@constructor']              = { link = 'Special' },
      ['@parameter']                = { link = 'Identifier' },
      ['@keyword']                  = { link = 'Keyword' },
      ['@keyword.conditional']      = { link = 'Conditional' },
      ['@keyword.debug']            = { link = 'Debug' },
      ['@keyword.directive']        = { link = 'PreProc' },
      ['@keyword.directive.define'] = { link = 'Define' },
      ['@keyword.exception']        = { link = 'Exception' },
      ['@keyword.function']         = { link = 'Keyword' },
      ['@keyword.import']           = { link = 'Include' },
      ['@keyword.operator']         = { link = 'Operator' },
      ['@keyword.repeat']           = { link = 'Repeat' },
      ['@keyword.return']           = { link = 'Keyword' },
      ['@keyword.storage']          = { link = 'StorageClass' },
      ['@conditional']              = { link = 'Conditional' },
      ['@repeat']                   = { link = 'Repeat' },
      ['@debug']                    = { link = 'Debug' },
      ['@label']                    = { link = 'Label' },
      ['@include']                  = { link = 'Include' },
      ['@exception']                = { link = 'Exception' },
      ['@type']                     = { link = 'Type' },
      ['@type.builtin']             = { link = 'Type' },
      ['@type.definition']          = { link = 'Typedef' },
      ['@type.qualifier']           = { link = 'Type' },
      ['@storageclass']             = { link = 'StorageClass' },
      ['@attribute']                = { link = 'PreProc' },
      ['@field']                    = { link = 'Identifier' },
      ['@property']                 = { link = 'Identifier' },
      ['@variable']                 = { link = 'Identifier' },
      ['@variable.builtin']         = { link = 'Special' },
      ['@variable.member']          = { link = 'Identifier' },
      ['@variable.parameter']       = { link = 'Identifier' },
      ['@constant']                 = { link = 'Constant' },
      ['@constant.builtin']         = { link = 'Special' },
      ['@constant.macro']           = { link = 'Define' },
      ['@markup']                   = { link = 'Normal' },
      ['@markup.strong']            = { fg = C.fg2, bold = true },
      ['@markup.emphasis']          = { fg = C.fg2, italic = true },
      ['@markup.italic']            = { link = '@markup.emphasis' },
      ['@markup.underline']         = { underline = true },
      ['@markup.strike']            = { strikethrough = true },
      ['@markup.heading.1']         = { link = 'markdownH1' },
      ['@markup.heading.2']         = { link = 'markdownH2' },
      ['@markup.heading.3']         = { link = 'markdownH3' },
      ['@markup.heading.4']         = { link = 'markdownH4' },
      ['@markup.heading.5']         = { link = 'markdownH5' },
      ['@markup.heading.6']         = { link = 'markdownH6' },
      ['@markup.raw']               = { fg = C.fg0, bg = C.blue_bg },
      ['@markup.raw.delimiter']     = { link = 'Comment' },
      ['@markup.raw.block']         = { },
      ['@markup.math']              = { link = '@markup.raw' },
      ['@markup.environment']       = { link = 'Macro' },
      ['@markup.environment.name']  = { link = 'Type' },
      ['@markup.link']              = { fg = C.bg3 },
      ['@markup.link.label']        = { fg = C.blue },
      ['@markup.link.url']          = { fg = C.br_blue, underline = true },
      ['@markup.list']              = { fg = C.br_green },
      ['@markup.list.checked']      = { fg = C.green, bold = true },
      ['@markup.list.unchecked']    = { fg = C.bg4 },
      ['@comment.todo']             = { link = 'Todo' },
      ['@comment.note']             = { link = 'SpecialComment' },
      ['@comment.warning']          = { link = 'WarningMsg' },
      ['@comment.error']            = { link = 'ErrorMsg' },
      ['@diff.plus']                = { link = 'diffAdded' },
      ['@diff.minus']               = { link = 'diffRemoved' },
      ['@diff.delta']               = { link = 'diffChanged' },
      ['@module']                   = { link = 'Type' },
      ['@namespace']                = { link = 'Type' },
      ['@symbol']                   = { link = 'Identifier' },
      ['@text']                     = { link = 'TSText' },
      ['@text.strong']              = { bold = true },
      ['@text.emphasis']            = { italic = true },
      ['@text.underline']           = { underline = true },
      ['@text.strike']              = { strikethrough = true },
      ['@text.title']               = { link = 'Title' },
      ['@text.literal']             = { link = 'String' },
      ['@text.uri']                 = { link = 'Underlined' },
      ['@text.math']                = { link = 'Special' },
      ['@text.environment']         = { link = 'Macro' },
      ['@text.environment.name']    = { link = 'Type' },
      ['@text.reference']           = { link = 'Constant' },
      ['@text.todo']                = { link = 'Todo' },
      ['@text.todo.checked']        = { link = '@markup.list.checked' },
      ['@text.todo.unchecked']      = { link = '@markup.list.unchecked' },
      ['@text.note']                = { link = 'SpecialComment' },
      ['@text.note.comment']        = { fg   = C.purple, bold = true },
      ['@text.warning']             = { link = 'WarningMsg' },
      ['@text.danger']              = { link = 'ErrorMsg' },
      ['@text.danger.comment']      = { fg   = C.fg0, bg = C.red, bold = true },
      ['@text.diff.add']            = { link = 'diffAdded' },
      ['@text.diff.delete']         = { link = 'diffRemoved' },
      ['@tag']                      = { link = 'Tag' },
      ['@tag.attribute']            = { link = 'Identifier' },
      ['@tag.delimiter']            = { link = 'elimiter' },
      ['@punctuation']              = { link = 'Delimiter' },
      ['@macro']                    = { link = 'Macro' },
      ['@structure']                = { link = 'Structure' },
      ['@lsp.type.class']           = { link = '@type' },
      ['@lsp.type.comment']         = { link = '@comment' },
      ['@lsp.type.decorator']       = { link = '@macro' },
      ['@lsp.type.enum']            = { link = '@type' },
      ['@lsp.type.enumMember']      = { link = '@constant' },
      ['@lsp.type.function']        = { link = '@function' },
      ['@lsp.type.interface']       = { link = '@constructor' },
      ['@lsp.type.macro']           = { link = '@macro' },
      ['@lsp.type.method']          = { link = '@method' },
      ['@lsp.type.namespace']       = { link = '@namespace' },
      ['@lsp.type.parameter']       = { link = '@parameter' },
      ['@lsp.type.property']        = { link = '@property' },
      ['@lsp.type.struct']          = { link = '@type' },
      ['@lsp.type.type']            = { link = '@type' },
      ['@lsp.type.typeParameter']   = { link = '@type.definition' },
      ['@lsp.type.variable']        = { link = '@variable' },
    },

    lsp = {
      -- LspReferenceText
      -- LspReferenceRead
      -- LspReferenceWrite
      -- LspCodeLens
      -- LspCodeLensSeparator
      LspSignatureActiveParameter = { fg = C.fg0, bg = C.aqua_bg, bold = true, italic = true },
    },

    -- 'tpope/vim-fugitive'
    fugitive = {
      fugitiveHeader              = { link = 'Comment' },

      fugitiveHash                = { fg   = C.br_blue },
      fugitiveSymbolicRef         = { link = 'gitcommitBranch' },
      fugitiveCount               = { link = 'Normal' },

      fugitiveHeading             = { fg = C.br_yellow, italic = true, bold = true },
      fugitiveUntrackedHeading    = { fg = C.br_aqua,   italic = true, bold = true },
      fugitiveUnstagedHeading     = { fg = C.br_orange, italic = true, bold = true },
      fugitiveStagedHeading       = { fg = C.br_green,  italic = true, bold = true },

      fugitiveModifier            = { fg = C.yellow },
      fugitiveUntrackedModifier   = { fg = C.aqua },
      fugitiveUnstagedModifier    = { fg = C.orange },
      fugitiveStagedModifier      = { fg = C.green },

      fugitiveSection             = { link = 'Normal' },
      fugitiveUntrackedSection    = { link = 'fugitiveSection' },
      fugitiveUnstagedSection     = { link = 'fugitiveSection' },
      fugitiveStagedSection       = { link = 'fugitiveSection' },

      fugitiveHelpHeader          = { link = 'fugitiveHeader' },
      fugitiveHelpTag             = { link = 'Tag' },
      fugitiveInstruction         = { link = 'Type' },
      fugitiveStop                = { link = 'Function' },
    },

    neogit = {
      NeogitCommitMessage        = { link = 'Comment' },
      NeogitBranch               = { fg = C.br_blue, bg = C.blue_bg, bold = true },
      NeogitRemote               = { fg = C.blue, bg = C.blue_bg, italic = true},
      NeogitObjectId             = { fg = C.br_blue },
      NeogitStash                = { link = 'NeogitObjectId' },
      NeogitRebaseDone           = { link = 'NeogitObjectId' },

      NeogitUntrackedfiles       = { fg = C.br_aqua,   italic = true, bold = true },
      NeogitUnstagedchanges      = { fg = C.br_orange, italic = true, bold = true },
      NeogitStagedchanges        = { fg = C.br_green,  italic = true, bold = true },
      NeogitStashes              = { fg = C.br_yellow, italic = true, bold = true },
      NeogitUnmergedInto         = { link = 'NeogitStashes' },
      NeogitUnpushedTo           = { link = 'NeogitStashes' },
      NeogitUnpulledFrom         = { link = 'NeogitStashes' },
      NeogitRecentcommits        = { link = 'NeogitStashes' },
      NeogitRebasing             = { link = 'NeogitStashes' },

      NeogitHunkHeader           = { fg = C.purple },
      NeogitHunkHeaderHighlight  = { fg = C.br_purple },
      NeogitDiffContext          = { fg = C.bg4 },
      NeogitDiffContextHighlight = { bg = bg },
      NeogitDiffAdd              = { fg = C.green, bg = C.green_bg },
      NeogitDiffAddHighlight     = { fg = C.green, bg = C.green_bg },
      NeogitDiffDelete           = { fg = C.red, bg = C.red_bg },
      NeogitDiffDeleteHighlight  = { fg = C.red, bg = C.red_bg },

      NeogitPopupSectionTitle    = { fg = C.yellow },
      NeogitPopupBranchName      = { link = 'NeogitBranch' },
      NeogitPopupBold            = { bold = true },
      NeogitPopupSwitchKey       = { fg = C.blue },
      NeogitPopupSwitchEnabled   = { fg = C.br_red },
      NeogitPopupSwitchDisabled  = { link = 'Comment' },
      NeogitPopupOptionKey       = { link = 'NeogitPopupSwitchKey' },
      NeogitPopupOptionEnabled   = { link = 'NeogitPopupSwitchEnabled' },
      NeogitPopupOptionDisabled  = { link = 'NeogitPopupSwitchDisabled' },
      NeogitPopupConfigKey       = { link = 'NeogitPopupSwitchKey' },
      NeogitPopupConfigEnabled   = { link = 'NeogitPopupSwitchEnabled' },
      NeogitPopupConfigDisabled  = { link = 'NeogitPopupSwitchDisabled' },
      NeogitPopupActionKey       = { fg = C.aqua },
      NeogitPopupActionDisabled  = { link = 'Comment' },

      NeogitCommitViewHeader     = { fg = C.yellow },
      NeogitFilePath             = { fg = C.fg1, italic = true },
      NeogitDiffHeader           = { fg = C.blue, bg = C.blue_bg },
      NeogitDiffHeaderHighlight  = { fg = C.br_blue, bg = C.blue_bg },
    },

    -- 'ntpeters/vim-better-whitespace'
    better_whitespace = {
      ExtraWhitespace = { fg = C.orange, bg = C.orange }, -- trailing whitespace
    },

    -- 'lukas-reineke/indent-blankline.nvim'
    indent_blankline = {
      IblIndent = { fg = C.bg1 },
      IblScope = { fg = C.bg4 },
    },

    -- 'lukas-reineke/virt-column.nvim'
    virt_column = {
      VirtColumn1  = { fg = C.bg1 },
      VirtColumn2  = { fg = C.dim_yellow, bg = C.bg0 },
      VirtColumn3  = { fg = C.dim_red, bg = C.orange_bg },
    },

    -- 'kyazdani42/nvim-tree.lua'
    nvim_tree = {
      NvimTreeRootFolder   = { fg = C.blue, bold = true },
      NvimTreeFolderIcon   = { link = 'NvimTreeFolderName' },
      NvimTreeFileIcon     = { fg = C.bg2 },
      NvimTreeSpecialFile  = { fg = C.fg2 },
      NvimTreeIndentMarker = { fg = C.bg3 },
      NvimTreeGitStaged    = { fg = C.br_green },
      NvimTreeGitRenamed   = { fg = C.br_yellow },
      NvimTreeGitNew       = { fg = C.br_aqua },
      NvimTreeGitDirty     = { fg = C.br_yellow },
      NvimTreeGitDeleted   = { fg = C.br_orange },
      NvimTreeGitMerge     = { fg = C.red },
    },

    -- 'nvim-telescope/telescope.nvim'
    telescope = {
      TelescopeBorder         = { link = 'FloatBorder' },
      TelescopePromptBorder   = { fg = C.br_blue, bg = bg },
      TelescopeTitle          = { link = 'FloatTitle' },
      TelescopePromptPrefix   = { link = 'FloatTitle' },
      TelescopePromptCounter  = { fg = C.bg3 },
      TelescopeNormal         = { link = 'Normal' },
      TelescopeMatching       = { link = 'Search' },
      TelescopeSelection      = { bg = C.blue_bg },
      TelescopeMultiSelection = { fg = C.orange, italic = true },
      TelescopeMultiIcon      = { link = 'TelescopeMultiSelection' },
    },

    -- 'neovim/nvim-lspconfig'
    lspconfig = {
      LspInfoTitle    = { link = 'FloatTitle' },
      LspInfoList     = { link = 'Function' },
      LspInfoFiletype = { link = 'Type' },
      LspInfoTip      = { link = 'Comment' },
      LspInfoBorder   = { link = 'FloatBorder' },
    },

    -- 'hrsh7th/nvim-cmp'
    nvim_cmp = {
      CmpItemAbbr             = { link = 'Comment' },
      CmpItemAbbrMatch        = { fg = C.br_purple, bg = C.purple_bg },
      CmpItemAbbrMatchFuzzy   = { link = 'CmpItemAbbrMatch' },

      CmpItemAbbrDeprecated   = { fg   = C.dim_orange, strikethrough = true },

      CmpItemMenu             = { fg   = C.bg2, italic = true },
      CmpItemKind             = { fg   = C.fg2 },
      CmpItemKindText         = { fg   = C.fg2, italic = true },

      CmpItemKindKeyword      = { fg   = C.dim_green },
      CmpItemKindUnit         = { link = 'CmpItemKindKeyword' },

      CmpItemKindInterface    = { fg   = C.dim_yellow },
      CmpItemKindClass        = { link = 'CmpItemKindInterface' },
      CmpItemKindEnum         = { link = 'CmpItemKindInterface' },
      CmpItemKindEvent        = { link = 'CmpItemKindInterface' },
      CmpItemKindModule       = { link = 'CmpItemKindInterface' },
      CmpItemKindReference    = { link = 'CmpItemKindInterface' },
      CmpItemKindStruct       = { link = 'CmpItemKindInterface' },
      CmpItemKindTypeParameter = { link = 'CmpItemKindInterface' },

      CmpItemKindVariable     = { fg   = C.dim_aqua },
      CmpItemKindField        = { link = 'CmpItemKindVariable' },
      CmpItemKindProperty     = { link = 'CmpItemKindVariable' },

      CmpItemKindFunction     = { fg   = C.dim_blue },
      CmpItemKindConstructor  = { link = 'CmpItemKindFunction' },
      CmpItemKindMethod       = { link = 'CmpItemKindFunction' },
      CmpItemKindOperator     = { link = 'CmpItemKindFunction' },

      CmpItemKindConstant     = { fg   = C.dim_orange },
      CmpItemKindColor        = { link = 'CmpItemKindConstant' },
      CmpItemKindEnumMember   = { link = 'CmpItemKindConstant' },

      CmpItemKindSnippet      = { fg   = C.dim_purple },

      CmpItemKindFile         = { link = 'CmpItemKindText' },
      CmpItemKindFolder       = { fg   = C.dim_blue },
    },

    -- 'mawkler/modicator.nvim'
    modicator = {
      NormalMode  = { fg = C.br_blue    },
      InsertMode  = { fg = C.br_green,  italic = true },
      VisualMode  = { fg = C.br_purple, italic = true},
      SelectMode  = { fg = C.br_purple, bold = true },
      CommandMode = { fg = C.br_yellow  },
      ReplaceMode = { fg = C.br_red,    bold = true, italic = true },
    },

    -- 'rhysd/git-messenger.vim'
    git_messenger = {
      gitmessengerPopupNormal = { link = 'Normal' },
      gitmessengerHeader      = { link = 'Function' },
      gitmessengerHash        = { link = 'Subtitle' },
      gitmessengerHistory     = { link = 'diffFile' },
    },

    -- 'j-hui/fidget.nvim'
    fidget = {
      FidgetTitle = { link = 'Title' },
      FidgetTask  = { link = 'String' },
    },

    -- 'rcarriga/nvim-notify'
    nvim_notify = {
      NotifyBackground = { fg = fg, bg = bg },
      NotifyLogTitle   = { fg = C.purple },
      NotifyLogTime    = { link = 'Comment' },

      NotifyTRACEIcon = { link = 'DiagnosticInfo' },
      NotifyDEBUGIcon = { link = 'DiagnosticHint' },
      NotifyINFOIcon  = { link = 'DiagnosticOk' },
      NotifyWARNIcon  = { link = 'DiagnosticWarn' },
      NotifyERRORIcon = { link = 'DiagnosticError' },

      NotifyTRACETitle = { link = 'DiagnosticInfo' },
      NotifyDEBUGTitle = { link = 'DiagnosticHint' },
      NotifyINFOTitle  = { link = 'DiagnosticOk' },
      NotifyWARNTitle  = { link = 'DiagnosticWarn' },
      NotifyERRORTitle = { link = 'DiagnosticError' },

      NotifyTRACEBorder = { link = 'DiagnosticInfo' },
      NotifyDEBUGBorder = { link = 'DiagnosticHint' },
      NotifyINFOBorder  = { link = 'DiagnosticOk' },
      NotifyWARNBorder  = { link = 'DiagnosticWarn' },
      NotifyERRORBorder = { link = 'DiagnosticError' },
    },
  }
end

M.setup = function()
  vim.cmd 'hi clear'
  if vim.fn.exists('syntax_on') then vim.cmd 'syntax reset' end
  vim.g.colors_name = 'gruvbox'

  local nvim_set_hl = vim.api.nvim_set_hl
  for _, section in pairs(M.highlights()) do
    for group_name, attributes in pairs(section) do
      nvim_set_hl(0, group_name, attributes)
    end
  end
end

return M

