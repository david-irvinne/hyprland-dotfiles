-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- lazygit
vim.keymap.set("n", "<leader>gg", function()
  vim.cmd("tabnew")
  vim.cmd("terminal lazygit")
  vim.cmd("startinsert")
end)
