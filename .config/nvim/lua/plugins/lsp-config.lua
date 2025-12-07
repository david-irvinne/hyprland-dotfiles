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

      -- HTML
      vim.lsp.config.html = {
        capabilities = capabilities,
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html' },
        root_markers = { '.git' },
      }
      -- JSON
      vim.lsp.config.jsonls = {
        capabilities = capabilities,
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json', 'jsonc' },
        root_markers = { '.git' },
      }
      -- Lua
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
      }
      -- TypeScript
      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
      -- CSS
      vim.lsp.config.cssls = {
        capabilities = capabilities,
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'less' },
        root_markers = { 'package.json', '.git' },
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }
      -- Tailwind CSS
      vim.lsp.config.tailwindcss = {
        capabilities = capabilities,
        cmd = { 'tailwindcss-language-server', '--stdio' },
        filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', '.git' },
      }
      -- C++
      vim.lsp.config.clangd = {
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--clang-tidy=false",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--all-scopes-completion",
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
        root_markers = { 'compile_commands.json', 'compile_flags.txt', '.git' },
        init_options = {
          clangdFileStatus = true,
          fallbackFlags = { "-Wall", "-Wextra", "-Wpedantic", "-Wshadow" },
        },
      }
      -- Golang
      vim.lsp.config.gopls = {
        capabilities = capabilities,
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
        end,
        settings = {
          gopls = {
            gofumpt = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      }
      -- Enable LSP servers
      vim.lsp.enable('html')
      vim.lsp.enable('jsonls')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('cssls')
      vim.lsp.enable('tailwindcss')
      vim.lsp.enable('clangd')
      vim.lsp.enable('gopls')
      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "always" }
      })
      -- Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" })
    end
  }
}
