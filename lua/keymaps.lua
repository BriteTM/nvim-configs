local map = vim.keymap.set

map('i', 'jk', '<Esc>')
map('n', '<leader>w', '<Cmd>w<CR>', { desc = 'Write' })
map('n', '<leader>so', '<Cmd>so<CR>', { desc = 'Source' })
map('n', '<leader>q', '<Cmd>q<CR>', { desc = 'Quit' })
map({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank to CB ' })
map({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from CB' })
map({ 'n', 'x' }, '<leader>fd', '<Cmd>Fb ~/Documents/Reports<CR>', { desc = 'Find Reports' })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map('n', '<C-H>', '<C-w>h')
map('n', '<C-J>', '<C-w>j')
map('n', '<C-K>', '<C-w>k')
map('n', '<C-L>', '<C-w>l')
map('n', '<leader>sv', '<Cmd>vsplit<CR>', { desc = 'Split Vertical' })
map('n', '<leader>sh', '<Cmd>split<CR>', { desc = 'Split Horizontal' })

map('n', '<leader>li', ':checkhealth vim.lsp<CR>', { desc = 'Show LSP Info' })


-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'Standard and Rust-specific LSP actions',
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local opts = { buffer = bufnr, silent = true }

		-- Auto Format
		if client and client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
				end,
				desc = 'Format on save'
			})
		end

		-- Keymaps
		map('n', 'gd', function() vim.lsp.buf.definition() end, opts)
		map('n', '<leader>cd', function() vim.diagnostic.open_float() end, opts)
		map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
		map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)

		-- Rustaceanvim Keybinds
		if client and client.name == 'rust-analyzer' then
			map('n', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end, opts)
			map('n', 'K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, opts)
			map('n', '<leader>lf', function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, { silent = true, buffer = bufnr, desc = 'Format Buffer' })
		else
			map('n', 'K', function() vim.lsp.buf.hover() end, opts)
			map('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
		end
	end
})

-- Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep (Search inside files)' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers' })
map("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, { desc = "Find LSP Symbols" })

map('n', '<leader>fh', builtin.help_tags, { desc = 'Search Neovim Help' })
map('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Search Functions/Variables' })
map('n', '<leader>fp', '<Cmd>Telescope projects<CR>', { desc = ' Find Project' })

-- Undotree
map('n', '<leader>u', '<Cmd>Undotreetoggle<CR>', { desc = 'Undotree' })

-- Harpoon
map('n', '<leader>ha', function() require('harpoon'):list():add() end, { desc = 'Harpoon Add' })
map('n', '<leader>he', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
	{ desc = 'Harpoon Menu' })
map('n', '<leader>1', function() require('harpoon'):list():select(1) end, { desc = 'Harpoon 1' })
map('n', '<leader>2', function() require('harpoon'):list():select(2) end, { desc = 'Harpoon 2' })
map('n', '<leader>3', function() require('harpoon'):list():select(3) end, { desc = 'Harpoon 3' })
map('n', '<leader>4', function() require('harpoon'):list():select(4) end, { desc = 'Harpoon 4' })

-- Persistence
map('n', '<leader>qs', function() require('persistence').load() end, { desc = 'Restore Session for CWD' })
map('n', '<leader>ql', function() require('persistence').load({ last = true }) end, { desc = 'Restore Last Session' })
map('n', '<leader>qd', function() require('persistence').stop() end, { desc = 'Stop Saving Session' })

-- Spotlight
local spotlight = require('spotlight')

map('n', '<leader>e', function() spotlight.open_explorer() end, { desc = 'File Browser' })
map('n', '<leader>.', function() spotlight.spotlight() end, { desc = 'Spotlight Runner' })
map('n', '<leader>cd', '<Cmd>Fb ~/<CR>', { desc = 'Change Directory' })
map('n', '<leader>t', function() spotlight.toggle_terminal() end, { desc = 'Toggle Terminal' })

-- Obsidian
map('n', '<leader>oo', '<Cmd>ObsidianQuickSwitch<CR>', { desc = 'Obsidian Quick Switch' })
map('n', '<leader>os', '<Cmd>ObsidianSearch<CR>', { desc = 'Obsidian Search' })
map('n', '<leader>on', '<Cmd>ObsidianNew<CR>', { desc = 'Obsidian New Note' })
map('n', '<leader>ot', '<Cmd>ObsidianToday<CR>', { desc = 'Obsidian Today (Daily Note)' })
