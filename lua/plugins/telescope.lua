return {
  {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep (Search inside files)' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers' })

            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search Neovim Help' })
            vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Search Functions/Variables' })
            vim.keymap.set('n', '<leader>fp', "<Cmd>Telescope projects<CR>", { desc = ' Find Project'})
        end
    },
  }
