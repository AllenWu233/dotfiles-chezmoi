-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- local save_fold = augroup("Persistent Folds", { clear = true })

-- Set identation for specific filetypes
local set_indentation = function(pattern, indentation)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.opt.shiftwidth = indentation
      vim.opt.tabstop = indentation
    end,
  })
end
set_indentation({ "lua", "html", "beancount", "ledger" }, 2)

-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end
-- set_autoformat({ "html" }, false)

-- Disable spelling check
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable automatic comment wrapping and insertion of comment leaders
cmd("autocmd BufEnter * silent! set formatoptions-=cro")
cmd("autocmd BufEnter * silent! setlocal formatoptions-=cro")

-- remember fold
-- cmd("autocmd BufWinLeave * silent! mkview")
-- cmd("autocmd BufWinEnter * silent! loadview")

-- autocmd("BufEnter", {
--   command = "set formatoptions-=cro",
-- })
--
-- autocmd("BufWinLeave", {
--   pattern = "*.*",
--   callback = function()
--     vim.cmd.mkview()
--   end,
--   group = save_fold,
-- })
--
-- autocmd("BufWinEnter", {
--   pattern = "*.*",
--   callback = function()
--     vim.cmd.loadview({ mods = { emsg_silent = true } })
--   end,
--   group = save_fold,
-- })

-- Floating window for showing line diagnostics automatically in hover window
-- autocmd({ "CursorHold", "CursorHoldI" }, {
autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
-- })

-- Disable autopair ' for rust files
autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.keymap.set("i", "'", "'", { buffer = 0 })
  end,
})

-- Set root directory
-- autocmd("BufEnter", {
--   pattern = "*",
--   callback = function()
--     vim.cmd("cd %:p:h")
--   end,
-- })
