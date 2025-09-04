return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim"
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {

        -- Lua
        null_ls.builtins.formatting.stylua,

        -- Javascript
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" }
        }),

        -- C++
        null_ls.builtins.formatting.clang_format,

        -- Golang
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.golines, -- opsional, biar rapiin panjang baris

        -- cpplint bego jir
        --require("none-ls.diagnostics.cpplint"),

        -- eslint baca semuanya jadi error :(
        --require("none-ls.diagnostics.eslint_d")
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
