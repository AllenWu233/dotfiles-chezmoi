-- ----- Plugins  ----- --
-- With short cofiguration
-- Others are devided into independent files
return {
  {
    "h-hg/fcitx.nvim", -- better input method
    event = { "FileReadPre", "BufReadPre", "User FileOpened" },
  },

  {
    "dccsillag/magma-nvim",
  },
}
