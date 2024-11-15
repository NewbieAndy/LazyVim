-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- 自动保存功能
local autosave_group = vim.api.nvim_create_augroup("AutoSaveGroup", { clear = true })

-- 离开插入模式后自动保存
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
  group = autosave_group,
  pattern = "*",
  command = "silent! wa",
})

-- 缓冲区变化后自动保存
vim.api.nvim_create_autocmd("TextChanged", {
  group = autosave_group,
  callback = function()
    vim.defer_fn(function()
      if vim.bo.modified then
        vim.cmd("silent! write")
      end
    end, 500) -- 延迟1秒
  end,
})
