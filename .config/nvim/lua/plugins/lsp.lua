return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    --{
    --    "L3MON4D3/LuaSnip",
    --    lazy = true,
    --    dependencies = { "rafamadriz/friendly-snippets" },
    --},
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = 'v0.8.1',

        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { preset = 'super-tab' },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- Will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            completion = {
                menu = {
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                    }
                }
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

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        enabled = false,
        --event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

            local luasnip = require('luasnip')
            local s, sn   = luasnip.snippet, luasnip.snippet_node
            local t, i, d = luasnip.text_node, luasnip.insert_node, luasnip.dynamic_node

            local function uuid()
                local id, _ = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
                return id
            end
            luasnip.add_snippets('all', {
                s({
                    trig = 'uuid',
                    name = 'UUID',
                    dscr = 'Generate a unique UUID'
                }, {
                    d(1, function() return sn(nil, i(1, uuid())) end)
                })
            })


            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()
            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<Tab>'] = cmp_action.luasnip_supertab(),
                    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            local lspconfig = require 'lspconfig'
            local lsp_defaults = lspconfig.util.default_config
            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('blink.cmp').get_lsp_capabilities()
            )

            lspconfig.lua_ls.setup {}
            lspconfig.pyright.setup {}
            lspconfig.dockerls.setup {}
            lspconfig.bashls.setup {}
            lspconfig.cssls.setup {}
            lspconfig.eslint.setup {}
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
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
        lazy = true,
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()',
    },
}
