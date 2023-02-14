-- ensure packer is installed, otherwise install it
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'  
    use {'folke/tokyonight.nvim', branch = 'main' } -- theme
    use 'https://github.com/ctrlpvim/ctrlp.vim.git' --ctrlp fuzzy search
    use 'sheerun/vim-polyglot' --various language syntax support 
    use 'mhinz/vim-startify'
    use 'kyazdani42/nvim-tree.lua' --lua nerdree but better i guess
    --airline stuff but without airline
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-web-devicons'
    --Language server things
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig',
        'neovim/nvim-lspconfig',
    }
    use {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
    }
    use 'windwp/nvim-autopairs'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({with_sync = true }) end,
    }
    -- Glow for Markdown previewing
    use {"ellisonleao/glow.nvim"}
    -- sync if new install
    if packer_bootstrap then
        require('packer').sync()
    end
end)
