local vim = vim
local telescope_builtin = require("telescope.builtin")
local mini_files = require('mini.files')

-- vim.keymap.set("n", "-", vim.cmd.Oil)
vim.keymap.set('n', '-', mini_files.open)
-- vim.keymap.set("n", "-", "lua MiniFiles.open()")

vim.keymap.set("n", "<Space>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<Space>cf", vim.cmd.LspZeroFormat)
-- i want to use <Space>ca to see lsp code actions, but not using LspZero

vim.keymap.set("n", "<Space>fb", telescope_builtin.buffers)
vim.keymap.set("n", "<Space>fp", telescope_builtin.find_files)
vim.keymap.set("n", "<Space>ff", telescope_builtin.live_grep)
vim.keymap.set("n", "<Space>fg", telescope_builtin.git_files)
vim.keymap.set("n", "<Space>fs", telescope_builtin.lsp_document_symbols)
vim.keymap.set("n", "<Space>fr", telescope_builtin.lsp_references)
vim.keymap.set("n", "<Space>re", telescope_builtin.registers)
