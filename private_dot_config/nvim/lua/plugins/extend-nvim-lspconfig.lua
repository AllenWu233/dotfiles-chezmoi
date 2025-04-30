-- -- Disable virtual text in lines
-- To show diagnostics, move cursor to the line to show a floating window
-- See `autocmds.lua` to get more
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
