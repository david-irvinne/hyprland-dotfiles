-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- delete default key for closing tab
vim.keymap.del("n", "<leader>bd")
-- go to last tab, then leader + w for closing tab
vim.keymap.set("n", "<leader>w", function()
  vim.cmd("bprevious | bd #")
end, { desc = "Close buffer safely" })

-- move between buffer
vim.keymap.set("n", "<A-l>", ":bnext<CR>")
vim.keymap.set("n", "<A-h>", ":bprevious<CR>")
-- move buffer
vim.keymap.set("n", "<A-S-l>", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })
vim.keymap.set("n", "<A-S-h>", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })

-- exit terminal job mode
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

local function handleCPPcompile(on_success)
  if vim.g.cpp_compiling then
    vim.notify("Compilation already in progress", vim.log.levels.WARN)
    return
  end
  vim.cmd("write")
  local src = vim.fn.expand("%:p")
  local out = vim.fn.expand("%:p:r")
  local fname = vim.fn.fnamemodify(src, ":t")
  local stderr = {}

  vim.g.cpp_compiling = true
  vim.notify("Compiling " .. fname .. "...", vim.log.levels.INFO, { title = "Compile" })

  vim.fn.jobstart({
    "clang++",
    "-std=c++23",
    "-DDEBUG",
    "-Wall",
    "-Wshadow",
    "-Wextra",
    "-D_GLIBCXX_DEBUG",
    src,
    "-o",
    out,
  }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stderr = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(stderr, line)
        end
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        vim.g.cpp_compiling = false
        if code == 0 then
          vim.notify("Build successful: " .. fname, vim.log.levels.INFO, { title = "Compile" })
          if on_success then
            on_success()
          end
        else
          local lines = {}
          for _, l in ipairs(stderr) do
            if l:match("^[^:]+:%d+:%d+:") then
              table.insert(lines, l)
            end
          end
          vim.fn.setqflist({}, "r", { title = "Compile", lines = lines, efm = "%f:%l:%c: %m" })
          vim.notify("Compile failed", vim.log.levels.ERROR, { title = "Compile" })
          vim.cmd("copen 8")
        end
      end)
    end,
  })
end

local function handleCPPrun()
  local bin = vim.fn.expand("%:p:r")
  vim.fn.jobstart({
    "alacritty",
    "--class",
    "nvim-run",
    "-e",
    "bash",
    "-c",
    ("%s; echo; read -n1 -s -r -p 'Press any key to close'"):format(vim.fn.shellescape(bin)),
  }, { detach = true })
end

-- F5: Compile C++ (async) → notif "Compiling..." saat jalan, error di quickfix
vim.keymap.set(
  "n",
  "<F5>",
  handleCPPcompile,
  { noremap = true, silent = false, desc = "Compile C++ (async, errors -> quickfix)" }
)

-- F6: Execute binary di window Alacritty terpisah (tidak memakai :terminal nvim)
vim.keymap.set(
  "n",
  "<F6>",
  handleCPPrun,
  { noremap = true, silent = false, desc = "Run binary in external Alacritty window" }
)

-- F7: compile and run c++ file
vim.keymap.set("n", "<F7>", function()
  handleCPPcompile(handleCPPrun)
end, { noremap = true, silent = false, desc = "Compile C++ and run its binary in external Alacritty window" })
