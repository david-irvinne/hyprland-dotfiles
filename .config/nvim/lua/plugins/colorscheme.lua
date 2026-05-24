return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
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
      vim.cmd.colorscheme "catppuccin"
      -- warna nomor biasa
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#B4BEFE" })
      -- warna nomor pada baris aktif
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F38BA8"  })
    end
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  }
}
