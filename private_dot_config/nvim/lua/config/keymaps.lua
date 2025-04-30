-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Leader key
-- vim.g.mapleader = " "

-- ---------- INSERT mode ---------- --
-- map("i", "jk", "<ESC>")
-- map("i", "kj", "<ESC>")

-- ---------- VISUAL mode ---------- --
-- map("v", "jk", "<ESC>")
-- map("v", "kj", "<ESC>")

-- ---------- NORMAL mode ---------- --
-- Select all
map("n", "<C-A>", "ggVGy", { desc = "Copy All" })
map("n", "<C-X>", "ggdG", { desc = "Delete All" })
-- map("n", "<leader>=", "gg=G", { desc = "Auto Indent" })

-- Move cursor
-- map("n", "<leader>j", "<C-w>j", { desc = "Move Down" })
-- map("n", "<leader>k", "<C-w>k", { desc = "Move Up" })
-- map("n", "<leader>h", "<C-w>h", { desc = "Move Left" })
-- map("n", "<leader>l", "<C-w>l", { desc = "Move Right" })

-- Buffers
-- map("n", "X", function()
--   Snacks.bufdelete()
-- end, { desc = "Delete Buffer" })

map("n", "<C-w>N", "<cmd>enew<cr>", { desc = "New File in Current Window" })
map("n", "<leader>wN", "<cmd>enew<cr>", { desc = "New File in Current Window" })
map("n", "<leader>r", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
map("n", "<leader>xc", "<cmd>Trouble close<cr>", { desc = "Close Trouble Window" })
map("n", "<D-s>", "<cmd>w<cr>", { desc = "Save" })
map("i", "<D-s>", "<Esc><cmd>w<cr>a", { desc = "Save" })

map("n", "<leader><delete>", function()
  Snacks.bufdelete()
end, { desc = "Close Buffer" })
map("n", "<leader><CR>", "<cmd>%bd<cr>", { desc = "Close All Buffers" })
map("n", "<leader>bo", Snacks.bufdelete.other, { desc = "Close Other Buffers" })

-- Fold or unfold
-- map("n", "<leader>a", "za", { desc = "Switch Fold" })

-- ---------- DISABLED ---------- --
-- map("n", "<C-y>", "")

-- ---------- PLUGINS ---------- --
-- compiler.nvim
-- Open compiler
map("n", "<C-b>", "<cmd>CompilerOpen<cr>", { desc = "Open Compiler", noremap = true, silent = true })

-- Redo last selected option
map(
  "n",
  "B",
  "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
    .. "<cmd>CompilerRedo<cr>",
  { desc = "Redo Compile", noremap = true, silent = true }
)

-- Toggle compiler results
map("n", "<M-b>", "<cmd>CompilerToggleResults<cr>", { desc = "Toggle Compiler", noremap = true, silent = true })
