vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 79
vim.cmd("set colorcolumn=79")

vim.lsp.config('basedpyright', {
	cmd = { 'basedpyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = {
		'pyproject.toml',
		'setup.py',
		'setup.cfg',
		'requirements.txt',
		'Pipfile',
		'pyrightconfig.json',
		'.git',
	},
	settings = {
		basedpyright = {
			analysis = {
				autoImportCompletions = false,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'openFilesOnly',
				diagnosticSeverityOverrides = {
					reportAny = false,
					reportExplicitAny = false,
					reportArgumentType = false,
					reportImplicitOverride = false,
					reportUnknownMemberType = false,
					reportUnknownArgumentType = false,

				},
			},
		},
	},
})

vim.lsp.enable('basedpyright')
