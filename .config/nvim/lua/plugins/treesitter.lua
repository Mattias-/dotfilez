local languages = {
    "bash",
    "c",
    "css",
    "diff",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "json5",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
    "ruby",
}
return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
    },
    {
        'MeanderingProgrammer/treesitter-modules.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        ---@module 'treesitter-modules'
        ---@type ts.mod.UserConfig
        opts = {
            ensure_installed = languages,
            auto_install = true,
            fold = { enable = true },
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = {
                    'typescript' -- So that: indentexpr=GetTypescriptIndent()
                }
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = '<c-i>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },
        },
    },
}
