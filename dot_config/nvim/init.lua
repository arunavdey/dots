-- GENERAL SETTINGS START
vim.g.mapleader = " "
vim.g.termguicolors = true
vim.g.background = "dark"
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.tabstop = 4
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
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            require("lualine").setup()
        end

    },
    { "sindrets/diffview.nvim" },
    { "preservim/tagbar" },
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
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup()
                    end
                },
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        'windwp/nvim-ts-autotag',
        event = "InsertEnter",
        config = true
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
vim.keymap.set(nv_mode, "<leader>tt", "<Cmd>TagbarToggle<CR>")
vim.keymap.set(nv_mode, "<leader>vv", "<Cmd>DiffviewOpen<CR>")
-- BINDS END
