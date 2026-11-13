return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		default = {
			-- Save into the vault's Images folder (absolute, so it works from any subfolder)
			dir_path = "/home/brite/Windows/Users/brite/Documents/Obsidian/Images",
			extension = "png",
			-- Matches Obsidian's naming: "Pasted image 20261111134600.png"
			file_name = "Pasted image %Y%m%d%H%M%S",
			prompt_for_file_name = false,
			use_absolute_path = false,
			relative_to_current_file = false,
		},
		filetypes = {
			markdown = {
				url_encode_path = false,
				-- Blank lines around the embed keep it on its own line, which fixes
				-- the image placement problem from before
				template = "\n![[$FILE_NAME]]\n",
			},
		},
	},
	keys = {
		{ "<C-p>", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
	},
}
