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
  require("config.extras.ai"),
  require("config.extras.autocompletion"),
  require("config.extras.blink"),
  require("config.extras.colorschemes"),
  require("config.extras.gitsigns"),
  require("config.extras.lsp"),
  require("config.extras.oil"),
  require("config.extras.telescope"),
  require("config.extras.tpope"),
  require("config.extras.treesitter"),
  require("config.extras.trouble")
})
