return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('rose-pine').setup({
                groups = {
                    comment = 'iris',
                },
                highlight_groups = {
                    SnacksPickerPathHidden = { fg = 'iris' },
                }
            })
            vim.cmd.colorscheme("rose-pine")
        end,
    },
    { 'b0o/schemastore.nvim' },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options    = {
                theme                = 'auto',
                section_separators   = '',
                component_separators = '',
            },
            sections   = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype', 'lsp_status' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            extensions = { 'quickfix', 'man', 'trouble' }
        }
    },
    {
        'tpope/vim-fugitive',
        cmd = { "Git", "GBrowse", "Gread", "Gvdiffsplit" },
        keys = {
            --{ "<leader>g", "<cmd>Git<cr>", desc = "Toggle Git" },
        },
    },
}
