-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.opt.winborder = "rounded"

vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

-- hapus comment continuation setelah tekan enter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "r", "o" })
  end,
})
