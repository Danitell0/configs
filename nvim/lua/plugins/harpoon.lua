local conf = require('telescope.config').values -- import telescope's default configurations
local themes = require('telescope.themes') -- import telescope's themes

-- function to open a telescope picker with the list of harpooned files
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    -- use the 'ivy' theme for the telescope picker
    local opts = themes.get_ivy({
        prompt_title = "Workspace List"
    })

    -- create and open a new telescope picker with the harpooned files
    require("telescope.pickers").new(opts, {
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer(opts), -- file previewer
        sorter = conf.generic_sorter(opts), -- sorts the list
    }):find()
end

return {
    "ThePrimeagen/harpoon", -- plugin directory
    branch = "harpoon2", -- harpoon2 here is the 'newer' branch
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require('harpoon') -- import the harpoon module
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end) -- add a file to the list
        vim.keymap.set("n", "<leader>fl", function() toggle_telescope(harpoon:list()) end, -- open up the list in telescope
            { desc = "Open harpoon window" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end) -- toggle the harpoon quick menu UI
        vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end) -- jump to the next harpooned file
        vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end) -- jump to the previous harpooned file
    end
}
