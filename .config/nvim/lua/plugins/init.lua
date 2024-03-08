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
            vim.cmd.colorscheme("rose-pine")
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
    {
        'tpope/vim-fugitive',
        dependencies = {
            'tpope/vim-rhubarb',
        },
        cmd = { "Git", "GBrowse" },
        keys = {
            { "<leader>g", "<cmd>Git<cr>", desc = "Toggle Git" },
        },
    },
    {
        "github/copilot.vim",
        config = function()
            vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false
            })
            vim.g.copilot_no_tab_map = true
        end,
    },
}
