return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
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
        { "<leader>g", function() require("telescope.builtin").grep_string() end },
        { "<C-p>",     function() require("telescope.builtin").git_files() end },
        { "<C-g>",     function() require("telescope.builtin").live_grep() end },
    },
}
