-- phosphor.lua
-- Green-on-black colorscheme with real syntax differentiation.
-- Place at: ~/.config/nvim/colors/phosphor.lua
-- Use with: vim.cmd("colorscheme phosphor")
--
-- Optional, set before the colorscheme call:
--   vim.g.phosphor_transparent    = true   -- use terminal background
--   vim.g.phosphor_mono_diagnostics = true -- keep errors/warnings in green too
--   vim.g.phosphor_italic_comments  = false

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "phosphor"

local transparent = vim.g.phosphor_transparent == true
local mono_diag = vim.g.phosphor_mono_diagnostics == true
local italic_comments = vim.g.phosphor_italic_comments ~= false

-- Palette: hue walks green -> lime -> aqua so groups stay distinguishable
-- without ever leaving the green family.
local c = {
	bg         = "#000000",
	bg_alt     = "#060a07", -- floats, sidebars, statusline
	bg_sel     = "#0e1f12", -- visual, cursorline
	bg_hl      = "#153021", -- search, matched text
	border     = "#1c3a24",

	dim        = "#1f6b33", -- comments, ignored text
	muted      = "#2f9e4f", -- punctuation, delimiters, operators
	fg         = "#46d97a", -- normal text, variables
	bright     = "#5cff8f", -- constants, bold
	pale       = "#d4ffd4", -- cursor, headings, high emphasis

	lime       = "#a8ff3e", -- strings
	olive      = "#c8e83c", -- numbers, booleans
	mint       = "#7dffb8", -- functions
	aqua       = "#00ffc8", -- types
	spring     = "#00e5a0", -- keywords
	moss       = "#6fbf73", -- parameters

	red        = "#ff5555",
	orange     = "#ffa057",
	yellow     = "#ffcc44",
}

if mono_diag then
	c.red = "#ff7b7b"
	c.orange = c.olive
	c.yellow = c.lime
end

local bg = transparent and "NONE" or c.bg
local bg_alt = transparent and "NONE" or c.bg_alt

local function hl(groups)
	for name, spec in pairs(groups) do
		vim.api.nvim_set_hl(0, name, spec)
	end
end

-- Editor UI ------------------------------------------------------------------
hl({
	Normal = { fg = c.fg, bg = bg },
	NormalNC = { fg = c.fg, bg = bg },
	NormalFloat = { fg = c.fg, bg = bg_alt },
	FloatBorder = { fg = c.border, bg = bg_alt },
	FloatTitle = { fg = c.bright, bg = bg_alt, bold = true },
	Cursor = { fg = c.bg, bg = c.pale },
	lCursor = { link = "Cursor" },
	CursorLine = { bg = c.bg_sel },
	CursorColumn = { bg = c.bg_sel },
	CursorLineNr = { fg = c.bright, bold = true },
	LineNr = { fg = c.dim },
	SignColumn = { bg = bg },
	FoldColumn = { fg = c.dim, bg = bg },
	Folded = { fg = c.muted, bg = c.bg_sel },
	ColorColumn = { bg = c.bg_sel },
	Visual = { bg = c.bg_hl },
	VisualNOS = { bg = c.bg_hl },
	Search = { fg = c.bg, bg = c.lime },
	IncSearch = { fg = c.bg, bg = c.pale },
	CurSearch = { link = "IncSearch" },
	MatchParen = { fg = c.pale, bold = true, underline = true },
	NonText = { fg = c.border },
	Whitespace = { fg = c.border },
	SpecialKey = { fg = c.border },
	EndOfBuffer = { fg = c.bg },
	Directory = { fg = c.aqua, bold = true },
	Title = { fg = c.pale, bold = true },
	Conceal = { fg = c.muted },
	VertSplit = { fg = c.border, bg = bg },
	WinSeparator = { fg = c.border, bg = bg },
	StatusLine = { fg = c.fg, bg = c.bg_alt },
	StatusLineNC = { fg = c.dim, bg = c.bg_alt },
	TabLine = { fg = c.muted, bg = c.bg_alt },
	TabLineSel = { fg = c.bright, bg = c.bg_sel, bold = true },
	TabLineFill = { bg = bg },
	WinBar = { fg = c.muted, bg = bg },
	WinBarNC = { fg = c.dim, bg = bg },
	Pmenu = { fg = c.fg, bg = c.bg_alt },
	PmenuSel = { fg = c.pale, bg = c.bg_hl, bold = true },
	PmenuSbar = { bg = c.bg_alt },
	PmenuThumb = { bg = c.muted },
	WildMenu = { link = "PmenuSel" },
	QuickFixLine = { bg = c.bg_hl },
	ModeMsg = { fg = c.bright, bold = true },
	MsgArea = { fg = c.fg },
	MoreMsg = { fg = c.aqua },
	Question = { fg = c.aqua },
	ErrorMsg = { fg = c.red, bold = true },
	WarningMsg = { fg = c.yellow },
})

-- Legacy syntax groups -------------------------------------------------------
hl({
	Comment = { fg = c.dim, italic = italic_comments },
	Constant = { fg = c.bright },
	String = { fg = c.lime },
	Character = { fg = c.lime },
	Number = { fg = c.olive },
	Boolean = { fg = c.olive, bold = true },
	Float = { fg = c.olive },
	Identifier = { fg = c.fg },
	Function = { fg = c.mint, bold = true },
	Statement = { fg = c.spring },
	Conditional = { fg = c.spring },
	Repeat = { fg = c.spring },
	Label = { fg = c.spring },
	Operator = { fg = c.muted },
	Keyword = { fg = c.spring, bold = true },
	Exception = { fg = c.spring, bold = true },
	PreProc = { fg = c.aqua },
	Include = { fg = c.aqua },
	Define = { fg = c.aqua },
	Macro = { fg = c.aqua, bold = true },
	PreCondit = { fg = c.aqua },
	Type = { fg = c.aqua },
	StorageClass = { fg = c.spring },
	Structure = { fg = c.aqua, bold = true },
	Typedef = { fg = c.aqua },
	Special = { fg = c.bright },
	SpecialChar = { fg = c.olive },
	Delimiter = { fg = c.muted },
	Tag = { fg = c.spring },
	Debug = { fg = c.orange },
	Underlined = { underline = true },
	Bold = { bold = true },
	Italic = { italic = true },
	Ignore = { fg = c.dim },
	Error = { fg = c.red },
	Todo = { fg = c.bg, bg = c.lime, bold = true },
})

-- Treesitter -----------------------------------------------------------------
hl({
	["@comment"] = { link = "Comment" },
	["@comment.error"] = { fg = c.red, bold = true },
	["@comment.warning"] = { fg = c.yellow, bold = true },
	["@comment.todo"] = { link = "Todo" },
	["@comment.note"] = { fg = c.aqua, bold = true },

	["@variable"] = { fg = c.fg },
	["@variable.builtin"] = { fg = c.spring, italic = true },
	["@variable.parameter"] = { fg = c.moss, italic = true },
	["@variable.member"] = { fg = c.bright },

	["@constant"] = { fg = c.bright, bold = true },
	["@constant.builtin"] = { fg = c.olive, bold = true },
	["@constant.macro"] = { fg = c.aqua, bold = true },

	["@module"] = { fg = c.aqua },
	["@module.builtin"] = { fg = c.aqua, bold = true },
	["@label"] = { fg = c.spring },

	["@string"] = { fg = c.lime },
	["@string.documentation"] = { fg = c.dim, italic = italic_comments },
	["@string.regexp"] = { fg = c.olive },
	["@string.escape"] = { fg = c.pale, bold = true },
	["@string.special"] = { fg = c.olive },
	["@string.special.url"] = { fg = c.aqua, underline = true },
	["@character"] = { fg = c.lime },
	["@character.special"] = { fg = c.pale },

	["@boolean"] = { fg = c.olive, bold = true },
	["@number"] = { fg = c.olive },
	["@number.float"] = { fg = c.olive },

	["@type"] = { fg = c.aqua },
	["@type.builtin"] = { fg = c.aqua, italic = true },
	["@type.definition"] = { fg = c.aqua, bold = true },
	["@attribute"] = { fg = c.olive },
	["@property"] = { fg = c.bright },

	["@function"] = { fg = c.mint, bold = true },
	["@function.builtin"] = { fg = c.mint, italic = true },
	["@function.call"] = { fg = c.mint },
	["@function.macro"] = { fg = c.aqua, bold = true },
	["@function.method"] = { fg = c.mint, bold = true },
	["@function.method.call"] = { fg = c.mint },
	["@constructor"] = { fg = c.aqua, bold = true },

	["@operator"] = { fg = c.muted },
	["@keyword"] = { fg = c.spring, bold = true },
	["@keyword.function"] = { fg = c.spring, bold = true },
	["@keyword.operator"] = { fg = c.spring },
	["@keyword.return"] = { fg = c.spring, bold = true, italic = true },
	["@keyword.import"] = { fg = c.aqua },
	["@keyword.conditional"] = { fg = c.spring },
	["@keyword.repeat"] = { fg = c.spring },
	["@keyword.exception"] = { fg = c.spring, bold = true },
	["@keyword.directive"] = { fg = c.aqua },

	["@punctuation.delimiter"] = { fg = c.muted },
	["@punctuation.bracket"] = { fg = c.muted },
	["@punctuation.special"] = { fg = c.bright },

	["@tag"] = { fg = c.spring },
	["@tag.builtin"] = { fg = c.spring, bold = true },
	["@tag.attribute"] = { fg = c.moss, italic = true },
	["@tag.delimiter"] = { fg = c.muted },

	["@markup.heading"] = { fg = c.pale, bold = true },
	["@markup.strong"] = { fg = c.bright, bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.link"] = { fg = c.aqua },
	["@markup.link.url"] = { fg = c.aqua, underline = true },
	["@markup.raw"] = { fg = c.lime },
	["@markup.list"] = { fg = c.spring },
	["@markup.quote"] = { fg = c.muted, italic = true },

	["@diff.plus"] = { fg = c.bright },
	["@diff.minus"] = { fg = c.red },
	["@diff.delta"] = { fg = c.olive },
})

-- LSP semantic tokens --------------------------------------------------------
hl({
	["@lsp.type.class"] = { link = "@type" },
	["@lsp.type.enum"] = { link = "@type" },
	["@lsp.type.interface"] = { link = "@type" },
	["@lsp.type.struct"] = { link = "@type" },
	["@lsp.type.typeParameter"] = { fg = c.aqua, italic = true },
	["@lsp.type.namespace"] = { link = "@module" },
	["@lsp.type.parameter"] = { link = "@variable.parameter" },
	["@lsp.type.property"] = { link = "@property" },
	["@lsp.type.variable"] = { link = "@variable" },
	["@lsp.type.function"] = { link = "@function" },
	["@lsp.type.method"] = { link = "@function.method" },
	["@lsp.type.macro"] = { link = "@function.macro" },
	["@lsp.type.enumMember"] = { link = "@constant" },
	["@lsp.type.comment"] = {},
	["@lsp.mod.readonly"] = { fg = c.bright },
	["@lsp.mod.deprecated"] = { strikethrough = true },
	["@lsp.typemod.variable.global"] = { fg = c.bright, bold = true },
})

-- Diagnostics ----------------------------------------------------------------
hl({
	DiagnosticError = { fg = c.red },
	DiagnosticWarn = { fg = c.yellow },
	DiagnosticInfo = { fg = c.aqua },
	DiagnosticHint = { fg = c.muted },
	DiagnosticOk = { fg = c.bright },
	DiagnosticUnderlineError = { sp = c.red, undercurl = true },
	DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
	DiagnosticUnderlineInfo = { sp = c.aqua, undercurl = true },
	DiagnosticUnderlineHint = { sp = c.muted, undercurl = true },
	DiagnosticVirtualTextError = { fg = c.red, bg = bg },
	DiagnosticVirtualTextWarn = { fg = c.yellow, bg = bg },
	DiagnosticVirtualTextInfo = { fg = c.aqua, bg = bg },
	DiagnosticVirtualTextHint = { fg = c.muted, bg = bg },
	DiagnosticUnnecessary = { fg = c.dim },

	LspReferenceText = { bg = c.bg_sel },
	LspReferenceRead = { bg = c.bg_sel },
	LspReferenceWrite = { bg = c.bg_hl, underline = true },
	LspInlayHint = { fg = c.dim, bg = c.bg_alt, italic = true },
	LspSignatureActiveParameter = { fg = c.pale, bold = true },
	LspCodeLens = { fg = c.dim, italic = true },
})

-- Diff / git -----------------------------------------------------------------
hl({
	DiffAdd = { fg = c.bright, bg = "#0a1f0f" },
	DiffChange = { fg = c.olive, bg = "#141f0a" },
	DiffDelete = { fg = c.red, bg = "#1f0a0a" },
	DiffText = { fg = c.pale, bg = "#1a3a20" },
	Added = { fg = c.bright },
	Changed = { fg = c.olive },
	Removed = { fg = c.red },

	GitSignsAdd = { fg = c.muted },
	GitSignsChange = { fg = c.olive },
	GitSignsDelete = { fg = c.red },
	GitSignsCurrentLineBlame = { fg = c.dim, italic = true },
})

-- Plugins you already have ---------------------------------------------------
hl({
	-- telescope
	TelescopeNormal = { fg = c.fg, bg = bg_alt },
	TelescopeBorder = { fg = c.border, bg = bg_alt },
	TelescopeTitle = { fg = c.bg, bg = c.muted, bold = true },
	TelescopePromptNormal = { fg = c.pale, bg = c.bg_sel },
	TelescopePromptBorder = { fg = c.bg_sel, bg = c.bg_sel },
	TelescopePromptTitle = { fg = c.bg, bg = c.lime, bold = true },
	TelescopePromptPrefix = { fg = c.lime },
	TelescopeSelection = { fg = c.pale, bg = c.bg_hl, bold = true },
	TelescopeSelectionCaret = { fg = c.lime, bg = c.bg_hl },
	TelescopeMatching = { fg = c.lime, bold = true },
	TelescopeMultiSelection = { fg = c.aqua },

	-- nvim-cmp
	CmpItemAbbr = { fg = c.fg },
	CmpItemAbbrDeprecated = { fg = c.dim, strikethrough = true },
	CmpItemAbbrMatch = { fg = c.lime, bold = true },
	CmpItemAbbrMatchFuzzy = { fg = c.lime },
	CmpItemMenu = { fg = c.dim, italic = true },
	CmpItemKindFunction = { fg = c.mint },
	CmpItemKindMethod = { fg = c.mint },
	CmpItemKindVariable = { fg = c.fg },
	CmpItemKindField = { fg = c.bright },
	CmpItemKindProperty = { fg = c.bright },
	CmpItemKindClass = { fg = c.aqua },
	CmpItemKindStruct = { fg = c.aqua },
	CmpItemKindInterface = { fg = c.aqua },
	CmpItemKindEnum = { fg = c.aqua },
	CmpItemKindKeyword = { fg = c.spring },
	CmpItemKindSnippet = { fg = c.olive },
	CmpItemKindText = { fg = c.lime },
	CmpItemKindConstant = { fg = c.bright },
	CmpItemKindModule = { fg = c.aqua },
	CmpItemKindFile = { fg = c.fg },
	CmpItemKindFolder = { fg = c.aqua },

	-- bufferline
	BufferLineFill = { bg = c.bg },
	BufferLineBackground = { fg = c.dim, bg = c.bg_alt },
	BufferLineBufferSelected = { fg = c.pale, bg = c.bg_sel, bold = true },
	BufferLineBufferVisible = { fg = c.muted, bg = c.bg_alt },
	BufferLineModified = { fg = c.olive, bg = c.bg_alt },
	BufferLineModifiedSelected = { fg = c.olive, bg = c.bg_sel },
	BufferLineSeparator = { fg = c.bg, bg = c.bg_alt },
	BufferLineSeparatorSelected = { fg = c.bg, bg = c.bg_sel },
	BufferLineIndicatorSelected = { fg = c.lime, bg = c.bg_sel },

	-- indent-blankline v3
	IblIndent = { fg = "#12210f" },
	IblScope = { fg = c.muted },

	-- noice / notify
	NoiceCmdlinePopup = { fg = c.fg, bg = bg_alt },
	NoiceCmdlinePopupBorder = { fg = c.border, bg = bg_alt },
	NoiceCmdlineIcon = { fg = c.lime },
	NoiceConfirmBorder = { fg = c.border },
	NotifyINFOBorder = { fg = c.muted },
	NotifyINFOIcon = { fg = c.aqua },
	NotifyINFOTitle = { fg = c.aqua },
	NotifyERRORBorder = { fg = c.red },
	NotifyERRORIcon = { fg = c.red },
	NotifyERRORTitle = { fg = c.red },
	NotifyWARNBorder = { fg = c.yellow },
	NotifyWARNIcon = { fg = c.yellow },
	NotifyWARNTitle = { fg = c.yellow },

	-- harpoon
	HarpoonWindow = { fg = c.fg, bg = bg_alt },
	HarpoonBorder = { fg = c.border, bg = bg_alt },

	-- deadcolumn
	DeadColumn = { bg = "#1a0a0a" },

	-- markview / markdown
	RenderMarkdownH1Bg = { bg = c.bg_sel },
	RenderMarkdownCode = { bg = c.bg_alt },

	-- which-key style helpers
	WhichKey = { fg = c.lime },
	WhichKeyGroup = { fg = c.aqua },
	WhichKeyDesc = { fg = c.fg },
	WhichKeySeparator = { fg = c.dim },
	WhichKeyFloat = { bg = bg_alt },
})

-- Terminal colors ------------------------------------------------------------
vim.g.terminal_color_0 = c.bg
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_2 = c.fg
vim.g.terminal_color_3 = c.olive
vim.g.terminal_color_4 = c.aqua
vim.g.terminal_color_5 = c.spring
vim.g.terminal_color_6 = c.mint
vim.g.terminal_color_7 = c.pale
vim.g.terminal_color_8 = c.dim
vim.g.terminal_color_9 = c.red
vim.g.terminal_color_10 = c.bright
vim.g.terminal_color_11 = c.lime
vim.g.terminal_color_12 = c.aqua
vim.g.terminal_color_13 = c.spring
vim.g.terminal_color_14 = c.mint
vim.g.terminal_color_15 = c.pale
