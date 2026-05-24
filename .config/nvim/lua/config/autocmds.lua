-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Force transparent backgrounds for common UI highlight groups.
-- This helps when some plugins (floats, Telescope, file tree, etc.) still set a solid bg.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_transparent_bg", { clear = true }),
  callback = function()
    local hl = function(name, opts)
      opts = opts or {}
      opts.bg = "NONE"
      vim.api.nvim_set_hl(0, name, opts)
    end

    -- Main editor
    hl("Normal")
    hl("NormalNC")
    hl("SignColumn")
    hl("EndOfBuffer")

    -- Floating windows / popups
    hl("NormalFloat")
    hl("FloatBorder")
    hl("FloatTitle")

    -- Common UI
    hl("Pmenu")
    hl("PmenuSel")
    hl("PmenuSbar")
    hl("PmenuThumb")

    -- Telescope
    hl("TelescopeNormal")
    hl("TelescopeBorder")
    hl("TelescopePromptNormal")
    hl("TelescopePromptBorder")
    hl("TelescopeResultsNormal")
    hl("TelescopeResultsBorder")
    hl("TelescopePreviewNormal")
    hl("TelescopePreviewBorder")

    -- Lazy (plugin UI)
    hl("LazyNormal")

    -- Neo-tree
    hl("NeoTreeNormal")
    hl("NeoTreeNormalNC")
    hl("NeoTreeEndOfBuffer")
    hl("NeoTreeFloatNormal")
    hl("NeoTreeFloatBorder")

    -- Which-key
    hl("WhichKeyFloat")
  end,
})
