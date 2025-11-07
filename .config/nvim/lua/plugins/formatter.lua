return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
        {
            -- Toggle autoformat
            "<leader>F",
            function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                print("Autoformat is now " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
            end,
            mode = "",
            desc = "Toggle autoformat",
        },
    },
    -- Everything in opts will be passed to setup()
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports", "gofumpt" },
            python = { "black" },
            javascript = { "biome" },
            json = { "biome" },
            typescript = { "biome" },
            typescriptreact = { "biome" },
            xml = { "xmllint" },
            sh = { "shfmt" },
            yaml = { "prettier" },
            nix = { "nixfmt" },
            --markdown = { "injected" },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "4" },
            },
        },
    },
    init = function()
        vim.g.disable_autoformat = false
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
