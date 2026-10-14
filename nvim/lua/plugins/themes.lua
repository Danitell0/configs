return {
	{ "navarasu/onedark.nvim", config = function() vim.cmd("colorscheme onedark") end },
	{ 'ribru17/bamboo.nvim', config = function() vim.cmd("colorscheme bamboo") end },
	{ "folke/tokyonight.nvim", config = function() vim.cmd("colorscheme tokyonight") end },
	{ "catppuccin/nvim", name = "catppuccin" , config = function() vim.cmd("colorscheme catppuccin") end },
	{ "rebelot/kanagawa.nvim", config = function() vim.cmd("colorscheme kanagawa") end },
	{ "shaunsingh/nord.nvim", config = function() vim.cmd("colorscheme nord") end },
	{ "https://codeberg.org/evergarden/nvim.git", config = function() vim.cmd("colorscheme evergarden") end },
	-- matches Ghostty's "iTerm2 Solarized Dark"
	{ "maxmx03/solarized.nvim", lazy = false, priority = 1000, opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- imports icon dependency
		},
		opts = {
			theme = "auto", -- follows the active colorscheme
			sections = {
				lualine_a ={
					{
						function()
							local reg = vim.fn.reg_recording()
							return ' recording to ' .. reg
						end,
						color = 'DiagnosticError',
						cond = function()
							return vim.fn.reg_recording() ~= ''
						end,
					},
				},
			},
		},
	},
}
