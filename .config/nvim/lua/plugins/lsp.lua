return {
    {
        'saghen/blink.cmp',
        lazy = true,
        version = 'v0.9.3',
        opts = {
            keymap = { preset = 'super-tab' },
            completion = {
                menu = {
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                    }
                },
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
            },
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'snippets', 'path', 'buffer' },
                cmdline = {},
            },
        },
        opts_extend = { "sources.default" }
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'saghen/blink.cmp' },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                pyright = {},
                dockerls = {},
                bashls = {},
                cssls = {},
                eslint = {},
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you've defined it
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities, true)
                lspconfig[server].setup(config)
            end
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {},
        ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "ray-x/guihua.lua",
        },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()',
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities({}, true)
            require('go').setup({
                luasnip = true,
                trouble = true,
                lsp_gofumpt = false, -- handled by conform instead.
                lsp_inlay_hints = {
                    enable = false,
                    show_variable_name = false,
                },
                lsp_keymaps = false,
                lsp_cfg = {
                    capabilities = capabilities,
                    settings = {
                        gopls = {
                            directoryFilters = { "-**/node_modules", "-**/.git", "-.vscode", "-.idea", "-.vscode-test" },
                            analyses = {
                                ST1003 = false,
                                -- shadow = false,
                            }
                        }
                    }
                },
            })
        end,
    },
}
