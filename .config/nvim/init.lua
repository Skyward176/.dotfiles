-- Fallback vimscript (hopefully don't need to touch that again)
vim.cmd([[
    
]])
local Plug = vim.fn['plug#']
vim.call('plug#begin')
    Plug ('folke/tokyonight.nvim', { branch = 'main' }) -- theme
    Plug 'https://github.com/ctrlpvim/ctrlp.vim.git' --ctrlp fuzzy search
    Plug 'sheerun/vim-polyglot' --various language syntax support 
    Plug ('prettier/vim-prettier', { ['do'] = 'yarn install --frozen-lockfile --production' }) --prettier... pretty
    Plug 'mhinz/vim-startify'
    Plug 'kyazdani42/nvim-tree.lua' --lua nerdree but better i guess
    --airline stuff but without airline
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    --Language server things
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'windwp/nvim-autopairs'

vim.call('plug#end')

-- Mappings from nvim lspconfig 

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- MUST USE THIS IN ALL require'lspconfig'.languageServer.setup{on_attach} calls!
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}


--Mappings for mason.nvim (lsp manager)

require("mason").setup(
)


-- basic configuration
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.number= true

-- Autopairs config
require("nvim-autopairs").setup{}

--colorscheme configuration
vim.cmd[[colorscheme tokyonight]]

-- shoving lualine in here too
require("lualine").setup{
    options = {
        theme='tokyonight'
    },
    tabline = {
      lualine_a = {
          {
            'buffers',
            show_modified_status = true,
            mode=4
          }
      },
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
    }
}
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true

--nvim tree
require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', '<C-t>', [[:NvimTreeToggle<CR>]], {})
-- ctrlp
vim.g.ctrlp_working_path_mode='ra'
vim.g.ctrlp_user_command = [[ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" -g "" ]]

--startify
vim.g.startify_files_number = 18
vim.g.startify_session_persistence = 1


vim.g.startify_custom_header = {
    [[  .__   __.  _______   ______   ____    ____  __  .___  ___.]],
    [[  |  \ |  | |   ____| /  __  \  \   \  /   / |  | |   \/   | ]],
    [[  |   \|  | |  |__   |  |  |  |  \   \/   /  |  | |  \  /  |]], 
    [[  |  . `  | |   __|  |  |  |  |   \      /   |  | |  |\/|  |]],
    [[  |  |\\   | |  |____ |  `--'  |    \\    /    |  | |  |  |  |]], 
    [[  |__| \__| |_______| \______/      \__/     |__| |__|  |__|]]}
