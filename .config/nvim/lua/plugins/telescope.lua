return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",
        event = "VeryLazy",
        opts = {
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                    '--glob=!.git/'
                },
            }
        },
        keys = {
            {
                "<leader>pw",
                "<cmd>lua require('telescope.builtin').grep_string()<cr>",
                desc = "Find word"
            },
            {
                "<leader>pW",
                "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cWORD>') })<cr>",
                desc = "Find WORD"
            },
            {
                "<C-p>",
                "<cmd>lua require('telescope.builtin').git_files()<cr>",
                desc = "Find git files"
            },
            {
                "<C-g>",
                "<cmd>lua require('telescope.builtin').live_grep()<cr>",
                desc = "Live grep"
            },
            {
                "<leader>pg",
                "<cmd>lua require('telescope.builtin').live_grep()<cr>",
                desc = "Live grep"
            },
            {
                "<leader>pk",
                "<cmd>lua require('telescope.builtin').keymaps()<cr>",
                desc = "Find keymaps"
            },
            {
                "<leader>b",
                "<cmd>lua require('telescope.builtin').buffers()<cr>",
                desc = "Find buffers"
            },
        },
    }
}
