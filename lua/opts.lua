vim.g.mapleader = " "
vim.opt.conceallevel = 2
vim.opt.scrolloff = 8
vim.opt.relativenumber = true
vim.opt.number = true;
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.linebreak = false

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})
