-- ----- Add Plugins ----- --
return {
  -- {
  --   "norcalli/nvim-colorizer.lua", -- color highlight
  --   keys = {
  --     {
  --       "<leader>uH",
  --       -- "<cmd>ColorizerAttachToBuffer<cr>",
  --       "<cmd>ColorizerToggle<cr>",
  --       { desc = "Toggle Color Highlight", noremap = true, silent = true },
  --     },
  --   },
  --   -- cmd = { "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffer", "ColorizerToggle" },
  --   -- event = "VeryLazy",
  -- },

  -- {
  --   "lunarvim/bigfile.nvim",
  --   config = function()
  --     require("bigfile").setup()
  --   end,
  --   event = { "FileReadPre", "BufReadPre", "User FileOpened" },
  -- },

  -- For productivity metrics, goals, leaderboards, and automatic time tracking
  -- { "wakatime/vim-wakatime", lazy = false },

  -- {
  --   "luozhiya/fittencode.nvim",
  --   config = function()
  --     require("fittencode").setup({
  --       keymaps = {
  --         inline = {
  --           ["<A-v>"] = "accept_all_suggestions",
  --         },
  --       },
  --     })
  --   end,
  -- },
}
