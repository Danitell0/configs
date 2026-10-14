return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = {
	  'nvim-lua/plenary.nvim',
	  'andrew-george/telescope-themes'
  },
  config = function()
	require("telescope").setup {
		defaults = {
			prompt_prefix = "   ",
			selection_caret = " -> ",
			entry_prefix = " ",
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					preview_width = 0.65,
				},
				width = 0.87,
				height = 0.80,
			},
			mappings = {
				n = {
					["q"] = require("telescope.actions").close,
					["<c-q>"] = require("telescope.actions").close,
				},
				i = {
					["<c-q>"] = require("telescope.actions").close,
					["<c-u>"] = false,
				},
			},
		},
		extensions_list = { "themes", "terms" },
		extensions = {
			file_browser = {
				hijack_netrw = true,
				hidden = { file_browser = true, folder_browser = true },
				mappings = {
					["i"] = {
						["<C-t>"] = require("telescope.actions").select_tab,
						["<C-c>"] = require "telescope".extensions.file_browser.actions.change_cwd,
					},
					["n"] = {
						-- normal mode bindings for file browser
					},
				},
			},
			themes = {
				enable_previewer = false,
				enable_live_preview = true,
				light_themes = {
					ignore = true,
					keywords = {"light", "day", "frappe", "lotus", "latte", "summer"}
				},
			},
			persist = {
				-- enable persisting last theme choice
				enabled = true,
			},
		},
	}
	require("telescope").load_extension "themes"
	require("telescope").load_extension "file_browser"
	require("telescope").load_extension "neoclip"
	require("telescope").load_extension "noice"
end
}
