-- GENERAL SETTINGS START
vim.g.mapleader = " "
vim.g.termguicolors = true
vim.g.background = "dark"
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
-- GENERAL SETTINGS END

-- PLUGINS START
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      vim.cmd.colorscheme("kanagawabones")
    end
  },
  { "neovim/nvim-lspconfig" },
  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        numhl = true,
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", vim.cmd.Oil)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local telescope_builtin = require("telescope.builtin")
      telescope.load_extension("fzf")
      telescope.setup()
      vim.keymap.set("n", "<Leader><Leader>", telescope_builtin.buffers)
      vim.keymap.set("n", "<Leader>fd", telescope_builtin.fd)
      vim.keymap.set("n", "<Leader>ff", telescope_builtin.live_grep)
      vim.keymap.set("n", "<Leader>re", telescope_builtin.registers)
      vim.keymap.set("n", "<Leader>dd", telescope_builtin.diagnostics)
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    }
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function()
      local harpoon = require("harpoon")
      harpoon.setup()
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        }):find()
      end

      vim.keymap.set("n", "<leader>e", function() toggle_telescope(harpoon:list()) end)
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>r", function() harpoon:list():remove() end)
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader>]", function() harpoon:list():next() end)
      vim.keymap.set("n", "<leader>[", function() harpoon:list():prev() end)
    end
  }
})
-- PLUGINS END

-- BINDS START
local nv_mode = { "n", "v" }
vim.keymap.set(nv_mode, "do", vim.diagnostic.open_float)
vim.keymap.set(nv_mode, "d]", vim.diagnostic.goto_next)
vim.keymap.set(nv_mode, "d[", vim.diagnostic.goto_prev)
vim.keymap.set(nv_mode, "gq", vim.lsp.buf.format)
vim.keymap.set(nv_mode, "gr", vim.lsp.buf.references)
vim.keymap.set(nv_mode, "gd", vim.lsp.buf.definition)
vim.keymap.set(nv_mode, "<F2>", vim.lsp.buf.rename)
-- BINDS END

-- LSP START
vim.lsp.enable("pyright")
vim.lsp.config("pyright", {})
vim.lsp.enable("rust-analyzer")
vim.lsp.config("rust-analyzer", {})
vim.lsp.enable("clangd")
vim.lsp.config("clangd", {})
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {})
vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", {})
vim.lsp.enable("gopls")
vim.lsp.config("gopls", {})
vim.lsp.enable("marksman")
vim.lsp.config("marksman", {})
vim.lsp.enable("prettier")
vim.lsp.config("prettier", {})
vim.lsp.enable("black")
vim.lsp.config("black", {})
-- LSP END
