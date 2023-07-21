local M = {}

M.colors = function()
  local c = {                  --  16  |  16   |  256   |
                               -- dark | light | colors |   R    G    B
                               --------+-------+--------+---------------
    dark0_h       = '#1d2021', --      |       |   233  |  29   32   33
    dark0         = '#282828', --    0 |       |   235  |  40   40   40
    dark0_s       = '#32302f', --      |       |   236  |  50   48   47
    dark1         = '#3c3836', --      |    15 |   237  |  60   56   54
    dark2         = '#504945', --      |       |   239  |  80   73   69
    dark3         = '#665c54', --      |       |   241  | 102   92   84
    dark4         = '#7c6f64', --      |     7 |   243  | 124  111  100
    gray          = '#928374', --    8 |     8 | 24[4,5]| 146  131  116
    light4        = '#a89984', --    7 |       |   246  | 168  153  132
    light3        = '#bdae93', --      |       |   248  | 189  174  147
    light2        = '#d5c4a1', --      |       |   250  | 213  196  161
    light1        = '#ebdbb2', --   15 |       |   223  | 235  219  178
    light0_s      = '#f2e5bc', --      |       |   228  | 242  229  188
    light0        = '#fbf1c7', --      |     0 |   229  | 253  244  193
    light0_h      = '#f9f5d7', --      |       |   230  | 249  245  215

    red_dark      = '#9d0006', --      |     9 |    88  | 157    0    6
    green_dark    = '#79740e', --      |    10 |   100  | 121  116   14
    yellow_dark   = '#b57614', --      |    11 |   136  | 181  118   20
    blue_dark     = '#076678', --      |    12 |    24  |   6  102  120
    purple_dark   = '#8f3f71', --      |    13 |    96  | 143   63  113
    aqua_dark     = '#427b58', --      |    14 |    66  |  66  123   88
    orange_dark   = '#af3a03', --      |       |   130  | 175   58    3

    red           = '#cc241d', --    1 |     1 |   123  | 204   36   29
    green         = '#98971a', --    2 |     2 |   106  | 152  151   26
    yellow        = '#d79921', --    3 |     3 |   172  | 215  153   33
    blue          = '#458588', --    4 |     4 |    66  |  69  133  136
    purple        = '#b16286', --    5 |     5 |   132  | 177   98  134
    aqua          = '#689d6a', --    6 |     6 |    72  | 104  157  106
    orange        = '#d65d0e', --      |       |   166  | 214   93   14

    red_light     = '#fb4934', --    9 |       |   167  | 251   73   52
    green_light   = '#b8bb26', --   10 |       |   142  | 184  187   38
    yellow_light  = '#fabd2f', --   11 |       |   214  | 250  189   47
    blue_light    = '#83a598', --   12 |       |   109  | 131  165  152
    purple_light  = '#d3869b', --   13 |       |   175  | 211  134  155
    aqua_light    = '#8ec07c', --   14 |       |   108  | 142  192  124
    orange_light  = '#fe8019', --      |       |   208  | 254  128   25
  }

  if vim.opt.background:get() == 'dark' then
    -- c.bg0   = c.dark0  -- default contrast
    -- c.bg0  = c.dark0_s -- soft contrast
    c.bg0  = c.dark0_h -- hard contrast

    c.bg1  = c.dark1
    c.bg2  = c.dark2
    c.bg3  = c.dark3
    c.bg4  = c.dark4

    c.fg0   = c.light0
    c.fg1   = c.light1
    c.fg2   = c.light2
    c.fg3   = c.light3
    c.fg4   = c.light4

    c.red_faded    = c.red_dark
    c.green_faded  = c.green_dark
    c.yellow_faded = c.yellow_dark
    c.blue_faded   = c.blue_dark
    c.purple_faded = c.purple_dark
    c.aqua_faded   = c.aqua_dark
    c.orange_faded = c.orange_dark
  else
    c.bg0   = c.light0     -- default contrast
    -- c.bg0  = c.light0_s -- soft contrast
    -- c.bg0  = c.light0_h -- hard contrast

    c.bg1  = c.light1
    c.bg2  = c.light2
    c.bg3  = c.light3
    c.bg4  = c.light4

    c.fg0   = c.dark0
    c.fg1   = c.dark1
    c.fg2   = c.dark2
    c.fg3   = c.dark3
    c.fg4   = c.dark4

    c.red_faded    = c.red_light
    c.green_faded  = c.green_light
    c.yellow_faded = c.yellow_light
    c.blue_faded   = c.blue_light
    c.purple_faded = c.purple_light
    c.aqua_faded   = c.aqua_light
    c.orange_faded = c.orange_light
  end

  return c
end

M.highlights = function()
  local C = M.colors()
  local fg = C.fg3
  local bg = C.bg0

  return {
    standard = {
      Normal         = { fg = fg, bg = bg },   -- normal text
      NormalNC       = { link = 'Normal' },    -- normal text in non-current windows

      Comment        = { fg = C.bg3, italic = true },  -- any comment

      Constant       = { fg   = C.orange },  -- any constant
      String         = { fg   = C.aqua   },  -- a string constant: "this is a string"
      Character      = { link = 'String' },  -- a character constant: 'c', '\n'
      Number         = { link = 'String' },  -- a number constant: 234, 0xff
      Boolean        = { fg = C.aqua, bold = true, italic = true },  -- a boolean constant: TRUE, false
      Float          = { link = 'String' },  -- a floating point constant: 2.3e10

      Identifier     = { fg   = C.fg3 },
      Function       = { fg   = C.blue },

      Statement      = { fg   = C.green    },   -- any statement
      Conditional    = { link = 'Statement' },  -- if, then, else, endif, switch, etc.
      Repeat         = { link = 'Statement' },  -- for, do, while, etc.
      Label          = { link = 'Statement' },  -- case, default, etc.
      Operator       = { link = 'Statement' },  -- "sizeof", "+", "*", etc.
      Keyword        = { link = 'Statement' },  -- any other keyword
      Exception      = { link = 'Statement' },  -- try, catch, throw

      PreProc        = { fg   = C.orange },     -- generic Preprocessor
      Include        = { link = 'PreProc' },    -- preprocessor #include
      Define         = { link = 'PreProc' },    -- preprocessor #define
      Macro          = { link = 'PreProc' },    -- same as Define
      PreCondit      = { link = 'PreProc' },    -- preprocessor #if, #else, #endif, etc.

      Type           = { fg   = C.yellow },     -- int, long, char, etc.
      StorageClass   = { link = 'Statement' },  -- static, register, volatile, etc.
      Structure      = { link = 'Statement' },  -- struct, union, enum, etc.
      Typedef        = { link = 'Statement' },  -- A typedef

      Special        = { fg   = C.red },        -- any special symbol
      SpecialChar    = { link = 'Special' },    -- special character in a constant
      Tag            = { link = 'Special' },    -- you can use CTRL-] on this
      Delimiter      = { link = 'Special' },    -- character that needs attention
      SpecialComment = { link = 'Special' },    -- special things inside a comment
      Debug          = { link = 'Special' },    -- debugging statements

      Underlined     = { fg = C.purple_faded, underline = true },
      Ignore         = { },
      Todo           = { fg = C.purple, bold = true },
      Error          = { fg = C.red },
      Warning        = { fg = C.yellow},
      Information    = { fg = C.blue },
      Hint           = { fg = C.aqua },
    },

    additional = {
      StatusLine     = { fg = C.fg3 , bg = C.bg2, reverse = true},
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
      CursorLine     = { bg = C.bg1 },
      CursorLineNr   = { fg = C.fg2 },

      IncSearch      = { fg = C.yellow, reverse = true },
      Search         = { fg = C.fg4 , reverse = true },

      DiffAdd        = { fg = C.green},
      DiffChange     = { fg = C.yellow},
      DiffDelete     = { fg = C.red},
      DiffText       = { fg = C.orange},
      diffAdded      = { link = 'DiffAdd' },
      diffRemoved    = { link = 'DiffDelete' },
      diffLine       = { fg = C.purple },
      diffSubname    = { link = 'diffine' },
      diffFile       = { fg = C.blue },
      diffIndexLine  = { link = 'diffFile' },

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
      VisualNOS      = { bg = C.bg2, reverse = true },
      WarningMsg     = { link = 'Warning' },
      WildMenu       = { fg = C.fg2, bg = C.bg2 },
      Folded         = { fg = C.blue, bg = bg },
      FoldColumn     = { fg = C.blue, bg = bg },

      Directory      = { fg = C.blue },

      NonText        = { fg = C.bg1 },                   -- subtle EOL symbols
      Whitespace     = { fg = C.orange },                -- listchars
      QuickFixLine   = { fg = C.yellow , bg = C.bg2 },   -- selected quickfix item

      TabLine     = { fg = C.fg4 , bg = C.bg2 },
      TabLineFill = { fg = C.fg4 , bg = C.bg2 },
      TabLineSel  = { fg = C.yellow, bg = bg },

      MatchParen  = { fg = C.red, bg = C.bg3, bold = true },
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
      vimCommentString   = { fg = C.purple_faded },
      vimCommand         = { fg = C.yellow },
      vimCmdSep          = { fg = C.blue, bold = true },
      helpExample        = { fg = C.fg3 },
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

      gitcommitBranch          = { fg = C.blue, bg = C.bg1 },
      gitcommitNoBranch        = { link = 'gitcommitBranch' },

      gitcommitHeader          = { fg = C.bg3 },
      gitcommitFile            = { fg = C.fg4 },

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
      markdownH1                  = { fg = C.yellow },
      markdownH2                  = { link = 'markdownH1' },
      markdownH3                  = { link = 'markdownH1' },
      markdownH4                  = { link = 'markdownH1' },
      markdownH5                  = { link = 'markdownH1' },
      markdownH6                  = { link = 'markdownH1' },
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

      markdownItalic              = { fg = C.fg3, italic = true },
      markdownBold                = { fg = C.fg3, bold = true },
      markdownBoldItalic          = { fg = C.fg3, bold = true, italic = true },
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
      TSStrong              = { fg = C.fg3, bold = true },
      TSEmphasis            = { fg = C.fg3, italic = true },
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
    },

    -- 'tpope/vim-fugitive'
    fugitive = {
      fugitiveHeader              = { link = 'Label' },

      fugitiveHash                = { fg   = C.purple_faded },
      fugitiveSymbolicRef         = { link = 'gitcommitBranch' },
      fugitiveCount               = { link = 'fugitiveUntrackedSection' },

      fugitiveHeading             = { fg   = C.yellow },
      fugitiveUntrackedHeading    = { link = 'gitcommitUntrackedFile' },
      fugitiveUnstagedHeading     = { link = 'gitcommitDiscardedFile' },
      fugitiveStagedHeading       = { link = 'gitcommitSelectedFile' },

      fugitiveSection             = { link = 'Normal' },
      fugitiveUntrackedSection    = { fg   = C.fg2 },
      fugitiveUnstagedSection     = { link = 'fugitiveUntrackedSection' },
      fugitiveStagedSection       = { link = 'fugitiveUntrackedSection' },

      fugitiveModifier            = { link = 'fugitiveHeading' },
      fugitiveUntrackedModifier   = { link = 'gitcommitUntrackedFile' },
      fugitiveUnstagedModifier    = { link = 'gitcommitDiscardedFile' },
      fugitiveStagedModifier      = { link = 'gitcommitSelectedFile' },

      fugitiveHelpHeader          = { link = 'fugitiveHeader' },
      fugitiveHelpTag             = { link = 'Tag' },
      fugitiveInstruction         = { link = 'Type' },
      fugitiveStop                = { link = 'Function' },
    },

    -- 'ntpeters/vim-better-whitespace'
    better_whitespace = {
      ExtraWhitespace = { fg = C.orange, bg = C.orange }, -- trailing whitespace
    },

    -- 'lukas-reineke/indent-blankline.nvim'
    indent_blankline = {
      IndentBlanklineChar = { fg = C.bg1 }, -- indentation guides
    },

    -- 'lukas-reineke/virt-column.nvim'
    virt_column = {
      VirtColumn  = { fg = C.bg1 },  -- virtual column
      ColorColumn = {},  -- otherwise this is visible behind VirtColumn
    },

    -- 'kyazdani42/nvim-tree.lua'
    nvim_tree = {
      NvimTreeRootFolder   = { fg = C.blue, bold = true },
      NvimTreeFolderIcon   = { link = 'NvimTreeFolderName' },
      NvimTreeSpecialFile  = { fg = C.fg2 },
      NvimTreeIndentMarker = { fg = C.bg3 },
      NvimTreeGitStaged    = { fg = C.green },
      NvimTreeGitRenamed   = { fg = C.yellow },
      NvimTreeGitNew       = { fg = C.yellow },
      NvimTreeGitDirty     = { fg = C.yellow },
      NvimTreeGitDeleted   = { fg = C.orange },
      NvimTreeGitMerge     = { fg = C.red },
    },

    -- 'nvim-telescope/telescope.nvim'
    telescope = {
      TelescopeBorder         = { fg = C.gray },
      TelescopePromptBorder   = { fg = C.fg0 },
      TelescopeTitle          = { fg = C.blue, bold = true },
      TelescopePromptPrefix   = { fg = C.blue },
      TelescopePromptCounter  = { fg = C.bg3 },
      TelescopeNormal         = { fg = C.gray },
      TelescopeMatching       = { fg = C.fg0 },
      TelescopeSelection      = { bg = C.bg1 },
      TelescopeMultiSelection = { fg = C.yellow, italic = true },
      TelescopeMultiIcon      = { link = 'TelescopeMultiSelection' },
    },

    -- 'hrsh7th/nvim-cmp'
    nvim_cmp = {
      CmpItemAbbr             = { link = 'Comment' },
      CmpItemAbbrMatch        = { fg   = C.fg0 },
      CmpItemAbbrMatchFuzzy   = { link = 'CmpItemAbbrMatch' },

      CmpItemAbbrDeprecated   = { fg   = C.orange, strikethrough = true },

      CmpItemKind             = { fg   = C.purple },
      CmpItemMenu             = { fg   = C.bg2, italic = true },

      CmpItemKindVariable     = { fg   = C.aqua },
      CmpItemKindInterface    = { link = 'CmpItemKindVariable' },
      CmpItemKindText         = { link = 'CmpItemKindVariable' },

      CmpItemKindFunction     = { fg   = C.blue },
      CmpItemKindMethod       = { link = 'CmpItemKindFunction' },

      CmpItemKindKeyword      = { fg   = C.green },
      CmpItemKindProperty     = { link = 'CmpItemKindKeyword' },
      CmpItemKindUnit         = { link = 'CmpItemKindKeyword' },

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

