return {
    {
        'saghen/blink.cmp',
        lazy = true,
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
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
            },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" }
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'saghen/blink.cmp', 'b0o/schemastore.nvim', },
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
                biome = {},
                templ = {},
                html = {
                    filetypes = { "html", "templ" }
                },
                yamlls = {
                    settings = {
                        yaml = {
                            schemaStore = {
                                -- You must disable built-in schemaStore support if you want to use
                                -- this plugin and its advanced options like `ignore`.
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                            schemas = require('schemastore').yaml.schemas {
                                extra = {
                                    {
                                        name = "openapi.json",
                                        description = "OAS",
                                        fileMatch = { "spec31.input.yaml" },
                                        url = "https://spec.openapis.org/oas/3.1/schema/2022-10-07",
                                    },
                                },
                            },
                        },
                    },
                },
            }
        },
        config = function(_, opts)
            for server, config in pairs(opts.servers) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            expose_as_code_action = { "all" },
        },
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
                luasnip = false,
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
                                ST1000 = false,
                                ST1003 = false,
                                -- shadow = false,
                            },
                        }
                    }
                },
            })
        end,
    },
}
