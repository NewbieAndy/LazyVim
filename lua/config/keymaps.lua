-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")
vim.keymap.del("n", "<leader>K")
vim.keymap.del("n", "<leader>/")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>w")
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
-- vim.keymap.del("n", "<leader>qd")
-- vim.keymap.del("n", "<leader>ql")
-- vim.keymap.del("n", "<leader>qq")
-- vim.keymap.del("n", "<leader>qs")

vim.keymap.set("n", "<leader>t", function()
  LazyVim.terminal(nil, { cwd = LazyVim.root(), reflash = true })
end, { desc = "Open terminal and refresh" })

vim.keymap.set("n", "<leader>n", "<cmd>enew<CR>", { desc = "new file", remap = true })

vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "lazyvim", remap = true })
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to the left window", remap = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to the down window", remap = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to the up window", remap = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to the right window", remap = true })
