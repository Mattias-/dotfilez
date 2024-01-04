return {
    {
        'folke/trouble.nvim',
        opts = { use_diagnostic_signs = true },
        cmd = { "Trouble" },
        keys = {
            {
                "<leader>tt",
                function()
                    require("trouble").toggle()
                end,
                desc = "Trouble Toggle",
            },
            {
                "<leader>tn",
                function()
                    require("trouble").next({ skip_groups = true, jump = true });
                end,
                desc = "Trouble Next",
            },
            {
                "<leader>tp",
                function()
                    require("trouble").previous({ skip_groups = true, jump = true });
                end,
                desc = "Trouble Previous",
            },
        },
    },
}
