return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = { "clangd", "lua_ls" }
        })

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("clangd")

        vim.keymap.set('n', '<leader>li', ':checkhealth vim.lsp<CR>', { desc = 'Show LSP Info' })

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'Standard LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf, silent = true }
                vim.keymap.set('n', 'K', function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set('n', '<leader>ca', function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set('n', 'gd', function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set('n', 'gl', function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set('n', '[d', function()
                    vim.diagnostic.jump({ count = -1 })
                end, opts)
                vim.keymap.set('n', ']d', function()
                    vim.diagnostic.jump({ count = 1 })
                end, opts)
            end
        })
    end
}
