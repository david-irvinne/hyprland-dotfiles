

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

require("vim-options")
require("lazy").setup("plugins")

-- F5: Compile file C++ jadi binary, tanpa eksekusi
vim.keymap.set("n", "<F5>", ":w<CR>:!g++ -std=c++20 -DDEBUG -Wall -Wshadow -Wextra % -o %:r<CR>", { noremap = true, silent = false })

-- move between tabs
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', ':bdelete<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>t', ':tabnew<CR>', { noremap = true, silent = true })
