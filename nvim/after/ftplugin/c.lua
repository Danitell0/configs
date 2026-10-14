vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.textwidth = 80
vim.cmd("set colorcolumn=80")

vim.lsp.config('clang', {
	cmd = {'clangd'},
	filetype = {'c', 'cpp'},
	root_markers = {'.clangd', 'compile_commands.json'},
})

vim.lsp.enable('clang')
