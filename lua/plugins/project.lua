return {
	'ahmedkhalf/project.nvim',
	config = function()
		require("project_nvim").setup({
			detection_methods = { "pattern" },
			patterns = { ".git/", "Makefile", "Cargo.toml", ".root" },
			scope_chdir = 'global',
		})
		pcall(function()
			require("telescope").load_extension("projects")
		end)
	end
}
