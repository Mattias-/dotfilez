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
vim.keymap.set("n", "<S-Tab>", ":tabprevious<cr>", { desc = "Tab previous" })

--vim.keymap.set("n", ":q", "<nop>")
vim.cmd [[nnoremap q: <nop>]]

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = "LSP: Run Codelens" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })

-- Other keymaps
-- https://github.com/ray-x/go.nvim/blob/master/lua/go/lsp.lua#L47
-- https://github.com/neovim/nvim-lspconfig
-- https://neovim.io/doc/user/lsp.html#lsp-config
-- grr gra grn gri i_CTRL-S Some keymaps are created unconditionally when Nvim starts:
-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
-- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
