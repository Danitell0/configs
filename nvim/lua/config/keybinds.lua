local map = vim.keymap.set
vim.g.mapleader = ' ' -- this maps the leader key to the spacebar

-- Quick esc
map("i", "<C-j>", "<Esc>")
map("t", "<C-j>", "<C-\\><C-N>")
map("t", "<Esc>", "<C-\\><C-N>")

-- Nav windows
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>l", "<C-w>l")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>v", ":vsplit<CR>")
map("n", "<leader>x", ":close<CR>")

-- Resize windows with arrows
map("n", "<C-Down>", ":resize +5<CR>", { desc = "Resize horizontal split down" })
map("n", "<C-Up>", ":resize -5<CR>", { desc = "Resize horizontal split up" })
map("n", "<C-Left>", ":vertical resize -5<CR>", { desc = "Resize vertical split left" })
map("n", "<C-Right>", ":vertical resize +5<CR>", { desc = "Resize vertical split right" })

-- Stay in indent mode when in visual
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Nav tabs
map("n", "<leader><tab>", ":tabedit<CR>")
map("n", "<leader>w", ":bd<CR>")
map("n", "<tab>", ":tabnext<CR>")
map("n", "<S-tab>", ":tabprev<CR>")

-- Nav terminal
map("n", "<leader>ft", ":ToggleTerm direction=float<CR>")
map("n", "<leader>t", ":ToggleTerm direction=horizontal<CR>")
map("t", "<C-x>", "<C-\\><C-N>:ToggleTerm<CR>")

-- Dismiss Noice Message
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>")

-- Telescope mappings
map("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope LSP diagnostics", noremap = true, silent = true })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
map("n", "<leader>fd", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Telescope file browser" })
map("n", "<leader>cs", ":Telescope themes<CR>", { desc = "Telescope colorscheme picker" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fo", ":Telescope oldfiles<CR>" , { desc = "Telescope old files" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope buffers" })
map("n", "<leader>fy", ":Telescope neoclip<CR>", { desc = "Telescope neoclip" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope help tags" })
