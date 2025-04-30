return {
  -- Set indent width of LSP formatter for c/cpp
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["cpp"] = { "clang_format" },
        ["c"] = { "clang_format" },
      },
      formatters = {
        clang_format = {
          prepend_args = { "-style={ IndentWidth: 4 }" },
        },
      },
    },
  },
}
