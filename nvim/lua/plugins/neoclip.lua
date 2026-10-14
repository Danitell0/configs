return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    {'nvim-telescope/telescope.nvim'},
  },
  config = function()
    require('neoclip').setup({
		keys = {
			telescope = {
				i = {
					select = '<cr>',
					paste = '<s-p>',
					paste_behind = '<c-k>',
					replay = '<nop>',  -- replay a macro
					delete = '<c-d>',  -- delete an entry
					edit = '<c-e>',  -- edit an entry
					custom = {},
				},
				n = {
					select = '<cr>',
					paste = 'p',
					--- It is possible to map to more than one key.
					-- paste = { 'p', '<c-p>' },
					paste_behind = 'P',
					replay = '<nop>',
					delete = 'd',
					edit = 'e',
					custom = {},
				},
			},
			fzf = {
				select = 'default',
				paste = 'ctrl-p',
				paste_behind = 'ctrl-k',
				custom = {},
			},
		},
	})
  end,
}
