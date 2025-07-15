-- GENERAL SETTINGS START
vim.g.mapleader = " "
vim.g.termguicolors = true
vim.g.background = "dark"
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.cmd.colorscheme("habamax")
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
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", vim.cmd.Oil)
    end,
  },
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
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
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
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
      fuzzy = { implementation = "lua" }
    }
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end
  },
  { 'neovim/nvim-lspconfig' }
})
-- PLUGINS END

-- MISC. BINDS START
local nv_mode = { "n", "v" }
vim.keymap.set(nv_mode, "do", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set(nv_mode, "d]", "<cmd>lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set(nv_mode, "d[", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set(nv_mode, "gq", "<cmd>lua vim.lsp.buf.format()<cr>")
vim.keymap.set(nv_mode, "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
vim.keymap.set(nv_mode, "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
-- MISC. BINDS END
