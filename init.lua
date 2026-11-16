require("opts")
require("plugins.themes")
require("config.lazy")
require("keymaps")

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.edit(vim.lsp.log.get_filename())
end, { desc = "Open the Neovim LSP log file" })
