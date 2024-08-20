local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true
                }
            })
        end
    },
    {
        -- "catppuccin/nvim",
        -- "rebelot/kanagawa.nvim",
        "ellisonleao/gruvbox.nvim",
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end
    },
    { "tpope/vim-commentary" },
    { "tpope/vim-surround" },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
        { "tpope/vim-rhubarb" },
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup({
                    numhl = true
                })
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
                { "nvim-lua/plenary.nvim" },
                { "BurntSushi/ripgrep" },
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            },
            config = function()
                local telescope = require("telescope")
                telescope.load_extension("fzf")
                telescope.setup({
                    defaults = {
                        layout_strategy = "current_buffer"
                    },
                })
            end
        },
        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v3.x",
            dependencies = {
                { "neovim/nvim-lspconfig" },
                { "hrsh7th/nvim-cmp" },
                { "hrsh7th/cmp-nvim-lsp" },
                {
                    "L3MON4D3/LuaSnip",
                    build = "make install_jsregexp",
                    dependencies = { "rafamadriz/friendly-snippets" },
                },
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" },
                { "folke/trouble.nvim" },
                { "stevearc/conform.nvim" },
                { "windwp/nvim-ts-autotag" },
            },
            config = function()
                local lsp_zero = require("lsp-zero")
                local cmp = require("cmp")
                local cmp_select = { behavior = cmp.SelectBehavior.Select }
                local mason = require("mason")
                local mason_lspconfig = require("mason-lspconfig")

                lsp_zero.on_attach(function(_, bufnr)
                    local opts = { buffer = bufnr, remap = false }
                    vim.keymap.set("n", "gd", function()
                        vim.lsp.buf.definition()
                    end, opts)
                    vim.keymap.set("n", "K", function()
                        vim.lsp.buf.hover()
                    end, opts)
                    vim.keymap.set("n", "[d", function()
                        vim.diagnostic.goto_next()
                    end, opts)
                    vim.keymap.set("n", "d]", function()
                        vim.diagnostic.goto_prev()
                    end, opts)
                end)

                mason.setup({})
                mason_lspconfig.setup({
                    ensure_installed = { "lua_ls" },
                    handlers = {
                        lsp_zero.default_setup,
                    }
                })

                cmp.setup({
                    sources = {
                        { name = "path" },
                        { name = "nvim_lsp" },
                        { name = "nvim_lua" },
                        { name = "luasnip", keyword_length = 2 },
                        { name = "buffer",  keyword_length = 3 },
                    },
                    formatting = lsp_zero.cmp_format(),
                    mapping = cmp.mapping.preset.insert({
                        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                        ['<C-Space>'] = cmp.mapping.complete()
                    })
                })
            end
        }
    })
