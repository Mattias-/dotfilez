return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
        cmd = "Telescope",
        event = "BufEnter",
        config = function()
            require('telescope').setup({
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
            })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pw", builtin.grep_string, { desc = "Find word" })
            vim.keymap.set("n", "<leader>pW", function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end, { desc = "Find WORD" })
            vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Find git files" })
            vim.keymap.set("n", "<C-g>", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>pk", builtin.keymaps, { desc = "Find keymaps" })
        end,
    }
}
