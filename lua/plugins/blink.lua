return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	opts = {
		enabled = function()
			return vim.bo.filetype ~= "markdown"
			    and vim.bo.buftype ~= "prompt"
			    and vim.b.completion ~= false
		end,
		keymap = {
			preset = "default",
			['<Tab>'] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback"
			},
			['<S-Tab'] = { 'snippet_backward', 'fallback' },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono"
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" }
}
