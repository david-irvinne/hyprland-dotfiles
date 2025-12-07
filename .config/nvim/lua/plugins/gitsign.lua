return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "~" },
          delete       = { text = "-" },
          topdelete    = { text = "^" },
          changedelete = { text = "#" },
        },
        current_line_blame = true, -- tampilkan blame per baris (opsional)
        on_attach = function(bufnr)
          local gs = require("gitsigns")

          -- Keymaps mirip VSCode
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigasi perubahan (hunk)
          map("n", "]c", function() gs.next_hunk() end)
          map("n", "[c", function() gs.prev_hunk() end)

          -- Aksi pada perubahan
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
          map("n", "<leader>hS", gs.stage_buffer)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hR", gs.reset_buffer)

          -- Preview perbedaan
          map("n", "<leader>hp", gs.preview_hunk)

          -- Toggle blame
          map("n", "<leader>hb", gs.toggle_current_line_blame)

          -- Toggle semua tanda
          map("n", "<leader>hd", gs.toggle_deleted)
        end,
      })
    end,
  },
}

