return {
	"3rd/image.nvim",
	build = false,
	opts = {
		backend = "kitty",
		processor = "magick_cli",
		max_width = 100,
		max_height = 12,
		window_overlap_clear_enabled = true,
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				resolve_image_path = function(document_path, image_path, fallback)
					-- Clean up wiki-link brackets if any slipped through
					image_path = image_path:gsub("^%[%[", ""):gsub("%]%]$", "")
					local ok, obsidian = pcall(require, "obsidian")
					if ok then
						local client = obsidian.get_client()
						if client then
							local vault_path = tostring(client:vault_root())
							local direct_path = vault_path .. "/Images/" .. image_path
							if vim.fn.filereadable(direct_path) == 1 then
								return direct_path
							end

							local found = vim.fn.glob(vault_path .. "/**/" .. image_path,
								false, true)
							if #found > 0 then
								return found[1]
							end
						end
					end
					return fallback(document_path, image_path)
				end,
			},
		},
	},
}
