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
                desc = "Trouble",
            },
            {
                "<leader>tn",
                function()
                    require("trouble").next({ skip_groups = true, jump = true });
                end,
            },
            {
                "<leader>tp",
                function()
                    require("trouble").previous({ skip_groups = true, jump = true });
                end,
            },
        },
    },
}
