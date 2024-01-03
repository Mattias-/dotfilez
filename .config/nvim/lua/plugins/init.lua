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
                }
            })
            vim.cmd([[colorscheme rose-pine]])
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme                = 'auto',
                section_separators   = '',
                component_separators = '',
            },
        }
    },
    { 'folke/trouble.nvim',          opts = { use_diagnostic_signs = true } },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
}
