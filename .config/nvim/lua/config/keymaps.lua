vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = "Escape from terminal" })
vim.keymap.set('', '<leader>l', ':set list! list?<cr>', { desc = "Toggle list" })
vim.keymap.set('', '<leader>w', ':set wrap! wrap?<cr>', { desc = "Toggle wrap" })
vim.keymap.set('', '<leader><space>', 'za', { desc = "Toggle fold" })
vim.keymap.set('n', '<leader>h', ':noh<cr>', { desc = "Clear highlight" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Repace selection with yanked" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete selection or movement to black hole register" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Substitue cursor word" })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })


vim.keymap.set("n", "<Tab>", ":tabnext<cr>", { desc = "Tab next" })
vim.keymap.set("n", "<S-Tab>", ":tabpreviouvs<cr>", { desc = "Tab previous" })
