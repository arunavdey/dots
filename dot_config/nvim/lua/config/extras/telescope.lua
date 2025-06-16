return {
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
  }
}
