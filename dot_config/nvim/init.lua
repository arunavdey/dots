local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

require("lazy").setup({
    {
        "stevearc/oil.nvim",
        lazy = false,
        opts = {
            default_file_explorer = true
        },
        keys = {
            { "-", "<cmd>Oil<cr>" }
        }
    },
    { "tpope/vim-fugitive" },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({ "lua", "vim", "vimdoc" })
            vim.api.nvim_create_autocmd("FileType", {
                callback = function() pcall(vim.treesitter.start) end,
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>" },
        },
        config = function()
            require("telescope").setup()
            pcall(require("telescope").load_extension, "fzf")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {},
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        opts = {
            options = { theme = "gruvbox" },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        opts = {},
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>" },
            { "<leader>gh", "<cmd>DiffviewFileHistory<cr>" },
        },
        opts = {
            use_icons = false,
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VimEnter",
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        event = "VimEnter",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VimEnter",
        config = function()
            require("ibl").setup()
        end,
    },
})
