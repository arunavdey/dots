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
        -- best file manager???
        'echasnovski/mini.nvim', version = '*',
        config = function()
            require('mini.files').setup()
            require('mini.trailspace').setup()
        end
    },
    {
        -- llm servant
        "zbirenbaum/copilot.lua",
        config = function()
            require('copilot').setup({
                suggestion = { enabled = false },
                panel = { enabled = false }
            })
        end
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require('copilot_cmp').setup()
        end
    },
    {
        -- adds bg transparency
        "xiyaowong/transparent.nvim",
        config = function()
            require("transparent").setup()
        end
    },
    {
        -- makes the code beautiful
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
        -- beautiful treesitter theme
        "sainnhe/sonokai",
        config = function()
            vim.cmd.colorscheme("sonokai")
        end
    },
    {
        -- makes commenting code easy
        "tpope/vim-commentary"
    },
    {
        -- makes surround code easy
        "tpope/vim-surround"
    },
    {
        -- better file browser
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end
    },
    {
        -- it's in the name
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        -- shows an undotree, useful sometimes
        "mbbill/undotree"
    },
    {
        -- makes git easy
        "tpope/vim-fugitive"
    },
    {
        -- makes remote git easy
        "tpope/vim-rhubarb"
    },
    {
        -- shows git signs in the gutter
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                numhl = true
            })
        end
    },
    {
        -- adds a floating window for many different tools
        -- greatest plugin ever?
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
        -- lsp
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
            { "stevearc/conform.nvim" },
            { "windwp/nvim-ts-autotag" },
            { "folke/trouble.nvim" },
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
                    { name = "copilot" },
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "buffer" },
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
