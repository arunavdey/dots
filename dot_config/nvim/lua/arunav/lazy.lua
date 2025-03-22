local vim = vim
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
    end,
  },
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
  { "tpope/vim-fugitive" },
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
      telescope.load_extension("fzf")
      telescope.setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' }
})
