return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()

    -- Install parsers needed for your setup (including typst for image.nvim)
    ts.install({
      "c",
      "lua",
      "markdown",
      "markdown_inline",
      "rust",
      "toml",
      "typst",
      "vim",
      "vimdoc",
    })

    -- Enable Treesitter highlighting automatically on supported filetypes
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
