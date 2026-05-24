-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- delete default key for closing tab
vim.keymap.del("n", "<leader>bd")
-- go to last tab, then leader + w for closing tab
vim.keymap.set("n", "<leader>w", function()
  vim.cmd("bprevious | bd #")
end, { desc = "Close buffer safely" })

-- move between buffer
vim.keymap.set("n", "<A-l>", ":bnext<CR>")
vim.keymap.set("n", "<A-h>", ":bprevious<CR>")
-- move buffer
vim.keymap.set("n", "<A-S-l>", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })
vim.keymap.set("n", "<A-S-h>", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })

-- exit terminal job mode
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
