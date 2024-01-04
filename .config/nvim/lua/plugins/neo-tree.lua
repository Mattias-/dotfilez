return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            filesystem = {
                group_empty_dirs = true,
                filtered_items = {
                    --visible = true,
                    hide_dotfiles = false,
                },
            },
        },
        keys = {
            { "<C-n>",     "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
            { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
            { '<leader>N', '<cmd>Neotree reveal<cr>' },
        },
    }
}
