return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            -- event = "notify",
            -- kind = "info",
            any = {
              -- { find = "# Plugin Updates" },

              -- Disable compile SUCCESS/FAILURE notification for compiler.nvim
              -- { event = "compiler.nvim" },
              -- { find = "compiler" },
              { find = "SUCCESS" },
              { find = "FAILURE" },
            },
          },
          opts = { skip = true },
        },
      },
    },
  },
}
