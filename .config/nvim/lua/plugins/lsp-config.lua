return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"lua_ls", "ts_ls", "clangd", "html", "tailwindcss", "jsonls", "cssls", "gopls"}
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      -- HTML
      lspconfig.html.setup({ capabilities = capabilities })
      -- JSON
      lspconfig.jsonls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
            -- TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.document_formatting = false -- Disable ts_ls formatting (use prettier instead)
        end,
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.document_formatting = false -- Disable cssls formatting
        end,
      })

      -- C++
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--clang-tidy=false",      -- Matikan clang-tidy
          "--completion-style=detailed",
          "--header-insertion=iwyu", -- Include what you use (bisa dimatikan kalau mau)
          "--all-scopes-completion",
        },
        init_options = {
          clangdFileStatus = true,
          fallbackFlags = { "-Wall", "-Wextra", "-Wpedantic", "-Wshadow" }, -- Warning bawaan compiler
        },
        root_dir = lspconfig.util.root_pattern(
          "compile_commands.json",
          "compile_flags.txt",
          ".git"
        )
      })

      -- Golang
      lspconfig.gopls.setup({
        capabilities = capabilities,

        on_attach = function(client, bufnr)
          -- kalau mau matiin format bawaannya, uncomment ini:
          -- client.server_capabilities.document_formatting = false
          -- biar bisa pakai goimports/null-ls

          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
        end,

        settings = {
          gopls = {
            gofumpt = true, -- auto format dengan gofumpt
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      })

      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "always" }
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" })

    end
  }
}
