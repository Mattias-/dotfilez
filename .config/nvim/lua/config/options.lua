vim.g.mapleader = ' '
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.foldlevel = 99

vim.opt.iskeyword:append("-")

vim.opt.listchars = {
    space = "·",
    trail = "·",
    tab = "▸ ",
    nbsp = "␣",
    precedes = "«",
    extends = "»",
    eol = "↲",
}

vim.o.completeopt = "menu,menuone,noselect"

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '󰌵',
        },
    }
})

vim.lsp.codelens.enable(true)
require('vim._core.ui2').enable({})

-- Truncate the LSP log on startup if it has grown beyond 500 MiB.
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.schedule(function()
            local log = vim.lsp.log.get_filename()
            local stat = vim.uv.fs_stat(log)
            if stat and stat.size > 500 * 1024 * 1024 then
                local fd = vim.uv.fs_open(log, "w", tonumber("644", 8))
                if fd then
                    vim.uv.fs_close(fd)
                end
            end
        end)
    end,
})
