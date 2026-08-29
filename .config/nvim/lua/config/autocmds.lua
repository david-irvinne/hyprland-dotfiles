-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function(args)
    vim.b[args.buf].autoformat = false
  end,
})

-- Autosave file yang sedang diedit setelah berhenti mengetik sejenak.
local autosave_group = vim.api.nvim_create_augroup("user_autosave", { clear = true })
local autosave_timers = {}

local function autosave(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  local should_save = vim.bo[buf].modified
    and vim.bo[buf].buftype == ""
    and vim.bo[buf].modifiable
    and vim.bo[buf].readonly == false

  if should_save then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent update")
    end)
  end
end

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = autosave_group,
  callback = function(args)
    local buf = args.buf
    if autosave_timers[buf] then
      autosave_timers[buf]:stop()
      autosave_timers[buf]:close()
    end

    autosave_timers[buf] = vim.defer_fn(function()
      autosave_timers[buf] = nil
      autosave(buf)
    end, 1000)
  end,
})

vim.api.nvim_create_autocmd({ "FocusLost", "VimLeavePre" }, {
  group = autosave_group,
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      autosave(buf)
    end
  end,
})
