return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	cmd = { "ObsidianQuickSwitch", "ObsidianSearch", "ObsidianNew", "ObsidianToday" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "vault",
				path = "~/Documents/Obsidian/",
			},
		},

		preferred_link_style = "markdown",

		daily_notes = {
			folder = "Daily Notes",
			date_format = "%Y-%m-%d",
		},

		completion = {
			nvim_cmp = false,
			min_chars = 2,
		},
	},
}
