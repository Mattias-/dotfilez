vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('', '<leader>l', ':set list! list?<cr>')
vim.keymap.set('', '<leader>w', ':set wrap! wrap?<cr>')
vim.keymap.set('', '<leader><space>', 'za')
vim.keymap.set('n', '<leader>h', ':noh<cr>')

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
