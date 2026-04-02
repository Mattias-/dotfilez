return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        requires = {
            "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
        },
        opts = {
            should_attach = function(_, bufname)
                if string.match(bufname, "Downloads") then
                    return false
                end
                return true
            end,
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<C-J>",
                }
            },
            filetypes = {
                yaml = true,
                help = false,
                --gitcommit = false,
                gitrebase = false,
                ["."] = false,
            }
        }
    },
}
