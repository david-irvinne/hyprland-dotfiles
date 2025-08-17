return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim"
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" }
        }),
        null_ls.builtins.formatting.clang_format,

        -- cpplint bego jir
        --require("none-ls.diagnostics.cpplint"),

        -- eslint baca semuanya jadi error :(
        --require("none-ls.diagnostics.eslint_d")
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
