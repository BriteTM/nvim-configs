local default_theme = "catppuccin"
local rust_theme = "ashen"

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("RustThemeSwitcher", { clear = true }),
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end

		local current_filetype = vim.bo[args.buf].filetype

		if current_filetype == "rust" then
			pcall(vim.cmd.colorscheme, rust_theme)
		else
			pcall(vim.cmd.colorscheme, default_theme)
		end
	end,
})

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end
	},

	{ "ficd0/ashen.nvim" },
}
