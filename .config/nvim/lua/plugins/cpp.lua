return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- matikan inlay hints (petunjuk parameter seperti "n: 5") untuk C/C++
      inlay_hints = {
        enabled = false,
      },
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
            "--all-scopes-completion",
          },

          filetypes = {
            "c",
            "cpp",
            "objc",
            "objcpp",
            "cuda",
            "proto",
          },

          root_markers = {
            "compile_commands.json",
            "compile_flags.txt",
            ".git",
          },

          init_options = {
            clangdFileStatus = true,

            fallbackFlags = {
              "-Wall",
              "-Wextra",
              "-Wpedantic",
              "-Wshadow",
            },
          },
        },
      },
    },
  },
}
