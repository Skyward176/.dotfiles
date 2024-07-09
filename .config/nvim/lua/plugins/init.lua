-- Note: this is where you can add plugins that don't require any configuration.
-- as soon as you need to add options to a plugin consider making a dedicated file.
local Plugins = {
    {'tpope/vim-repeat'},
    {'tpope/vim-fugitive'},

    {'stevearc/dressing.nvim', opts = {}},

    {'nvim-tree/nvim-web-devicons', lazy = true},

    {'svermeulen/vim-subversive'},
    {'svermeulen/vim-cutlass'},

    -- colorscheme
    {'folke/tokyonight.nvim'},

    -- airline
    {'nvim-lualine/lualine.nvim'},
    -- discord presence
    {'IogaMaster/neocord', event = 'VeryLazy'},
    -- autopairs
    {'windwp/nvim-autopairs', event = "InsertEnter", config = true},
    -- nvim-surround for editing all sorts of paired surrounding marks
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },
    -- treesitter objects 
    {'nvim-treesitter/nvim-treesitter-textobjects'}

}

return Plugins
