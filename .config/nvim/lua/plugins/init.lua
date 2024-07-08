-- Note: this is where you can add plugins that don't require any configuration.
-- as soon as you need to add options to a plugin consider making a dedicated file.
local Plugins = {
  {'tpope/vim-repeat'},
  {'tpope/vim-fugitive'},

  {'stevearc/dressing.nvim', opts = {}},

  {'nvim-tree/nvim-web-devicons', lazy = true},

  {'svermeulen/vim-yoink'},
  {'svermeulen/vim-subversive'},
  {'svermeulen/vim-cutlass'},

  -- colorscheme
  {'folke/tokyonight.nvim'},

  -- airline
  {'nvim-lualine/lualine.nvim'},

}

return Plugins
