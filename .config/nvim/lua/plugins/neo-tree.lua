return  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", 
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    require("neo-tree").setup({
      window = { width = 25}
    })
    vim.keymap.set('n', '<c-n>', ':Neotree filesystem reveal left<cr>', {})
  end
} 

