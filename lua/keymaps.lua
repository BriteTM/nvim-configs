local map = vim.keymap.set

-- General Mappings
map("i", "jk", "<Esc>")
map("n", "<leader>w", "<Cmd>w<CR>")
map("n", "<leader>q", "<Cmd>q<CR>")
map({"n", "x"}, "<leader>y", '"+y', { desc = "Yank to CB "} )
map({"n", "x"}, "<leader>p", '"+p', { desc = "Paste from CB"} )

-- Split mappings
map("n", "<C-H>", "<C-w>h")
map("n", "<C-J>", "<C-w>j")
map("n", "<C-K>", "<C-w>k")
map("n", "<C-L>", "<C-w>l")
map("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split Vertical" } )
map("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split Horizontal" } )

