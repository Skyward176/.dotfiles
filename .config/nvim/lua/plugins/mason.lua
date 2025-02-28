local Plugins = {
    -- LSP install and support
    {
        "williamboman/mason.nvim",
        lazy=false,
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim", 
        config = function()
            require("mason-lspconfig").setup()
            require("lspconfig").pylsp.setup{
                settings = {
                    pylsp = {
                        plugins = {
                            mypy = {
                                enabled = true,
                                live_mode = true,
                            },
                        }
                    }
                }
            }
        end
    },
    {"neovim/nvim-lspconfig"},
}
return Plugins
