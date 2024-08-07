local vim = vim
local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "-", vim.cmd.Oil)

vim.keymap.set("n", "<Space>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<Space>fb", telescope_builtin.buffers)
vim.keymap.set("n", "<Space>fp", telescope_builtin.find_files)
vim.keymap.set("n", "<Space>ff", telescope_builtin.live_grep)
