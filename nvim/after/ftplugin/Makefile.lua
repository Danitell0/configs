vim.lsp.config('mbake', {
	cmd = {'mbake'},
	filetype = {'Makefile'},
	root_markers = {'.mbake'},
})

vim.lsp.enable('mbake')
