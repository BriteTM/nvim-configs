return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false,
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                if client.name == "rust-analyzer" then
                    vim.keymap.set("n", "<leader>ca", function()
                        vim.cmd.RustLsp('codeAction')
                    end, { silent = true, buffer = bufnr })

                    vim.keymap.set("n", "<leader>lf", function()
                      vim.lsp.buf.format({ bufnr = bufnr })
                    end, {silent = true, buffer = bufnr, desc = "Format Buffer"})

                    vim.keymap.set("n", "K", function()
                        vim.cmd.RustLsp({'hover', 'actions'})
                    end, { silent = true, buffer = bufnr })
                end
            end,
        })
    end,

}
