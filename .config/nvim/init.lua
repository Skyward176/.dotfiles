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
require("nvim-autopairs").setup{}

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

--rich presence

-- The setup config table shows all available config options with their default values:
require("presence").setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

vim.g.startify_custom_header = {
    [[  .__   __.  _______   ______   ____    ____  __  .___  ___.]],
    [[  |  \ |  | |   ____| /  __  \  \   \  /   / |  | |   \/   | ]],
    [[  |   \|  | |  |__   |  |  |  |  \   \/   /  |  | |  \  /  |]], 
    [[  |  . `  | |   __|  |  |  |  |   \      /   |  | |  |\/|  |]],
    [[  |  |\ \ | |  |____ |  `--'  |    \\   /    |  | |  |  |  |]], 
    [[  |__| \__| |_______| \______/      \__/     |__| |__|  |__|]]}
