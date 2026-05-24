return {
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   config = function()
  --     require("gruvbox").setup({
  --       transparent_mode = true,
  --     })
  --   end,
  -- },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        float = {
          transparent = true,
          solid = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
      -- warna nomor biasa
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#B4BEFE" })
      -- warna nomor pada baris aktif
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F38BA8" })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "gruvbox",
    },
  },
}
