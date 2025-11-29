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
                    hide_by_name = { ".git", ".DS_Store" },
                },
            },
            window = {
                mappings = {
                    ["Y"] = {
                        function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.fn.setreg("+", path, "c")
                        end,
                        desc = "Copy Path to Clipboard",
                    },
                    ["c"] = {
                        "copy",
                        config = {
                            show_path = "absolute" -- "none", "relative", "absolute"
                        }
                    }
                },
            },
        },
        keys = {
            { "<C-n>",     "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
            { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Toggle NeoTree" },
            { '<leader>N', '<cmd>Neotree reveal<cr>', desc = "Show file in NeoTree" },
        },
    }
}
