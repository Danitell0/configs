return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		debounce = 100,
		indent = { char = "|" },
		whitespace = { highlight = { "Whitespace", "NonText" } },
	},
}
