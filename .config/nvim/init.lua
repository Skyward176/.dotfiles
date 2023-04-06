-- Plugin installation
require('plugins')

-- basic configuration
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true vim.opt.number= true
vim.o.completeopt='menu,menuone,noselect' vim.g.mapleader = ' '

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
---- Autopairs config
--require("nvim-autopairs").setup{}
--
--colorscheme configuration
require("tokyonight").setup({
    style = "night",
    styles = {
        functions = { italic=true }
    }
})
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

-- Treesitter
require('nvim-treesitter.configs').setup{
  ensure_installed = {'lua', 'java', 'python', 'javascript', 'c'},
  auto_install = true,
  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
   end,
  }
}

-- Glow
require('glow').setup({
  -- your override config
})

-- Telescope mappings
require("telescope").setup {
    extensions = {
        file_browser = {
        }
    }
}

require("telescope").load_extension "file_browser"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>fe', ':Telescope file_browser', { noremap = true })

--startify
vim.g.startify_files_number = 18
vim.g.startify_session_persistence = 1


vim.g.startify_custom_header = {
    [[  .__   __.  _______   ______   ____    ____  __  .___  ___.]],
    [[  |  \ |  | |   ____| /  __  \  \   \  /   / |  | |   \/   | ]],
    [[  |   \|  | |  |__   |  |  |  |  \   \/   /  |  | |  \  /  |]], 
    [[  |  . `  | |   __|  |  |  |  |   \      /   |  | |  |\/|  |]],
    [[  |  |\ \ | |  |____ |  `--'  |    \\   /    |  | |  |  |  |]], 
    [[  |__| \__| |_______| \______/      \__/     |__| |__|  |__|]]}
