local vim = vim
local telescope_builtin = require("telescope.builtin")

vim.keymap.set("n", "-", vim.cmd.Oil)
vim.keymap.set("n", "<Space>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<Space><Space>", telescope_builtin.buffers)
vim.keymap.set("n", "<Space>fd", telescope_builtin.fd)
vim.keymap.set("n", "<Space>ff", telescope_builtin.live_grep)
vim.keymap.set("n", "<Space>re", telescope_builtin.registers)
vim.keymap.set("n", "<Space>dd", telescope_builtin.diagnostics)
vim.keymap.set("n", "<Space>do", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "<Space>xx", "<cmd>Trouble diagnostics toggle<cr>")

vim.keymap.set({ "n", "v" }, "<Space>cc", vim.cmd.CodeCompanionAction)

