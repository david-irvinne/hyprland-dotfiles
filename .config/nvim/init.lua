-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- lazygit
vim.keymap.set("n", "<leader>gg", function()
  vim.cmd("tabnew")
  vim.cmd("terminal lazygit")
  vim.cmd("startinsert")
end)

-- capslock for normal mode
-- vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
--   callback = function()
--     os.execute("gsettings set org.gnome.desktop.input-sources xkb-options \"['caps:escape_shifted_capslock']\"")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ "VimLeave", "FocusLost" }, {
--   callback = function()
--     os.execute('gsettings set org.gnome.desktop.input-sources xkb-options "[]"')
--   end,
-- })
