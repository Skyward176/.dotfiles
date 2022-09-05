-- Plugin installation
require('plugins')

-- basic configuration
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.number= true
vim.o.completeopt='menu,menuone,noselect'


--Mappings for mason.nvim (lsp manager)

require("mason").setup(
)
require("mason-lspconfig").setup(

)
local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers {
    -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
    function (server_name)
       lspconfig[server_name].setup {
           on_attach = require("lsp_bindings").on_attach(client, bufnr)
       }
    end
}

-- config for global lsp commands, provided from nvim-lspconfig doc
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- nvim cmp config
local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 3},
        {name = 'buffer', keyword_length = 3},
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}),

        ['<C-d>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {'i', 's'}),

        ['<C-b>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'}),

        ['<Tab>'] = cmp.mapping(function(fallback)
          local col = vim.fn.col('.') - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
        end, {'i', 's'}),
    },
})
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
