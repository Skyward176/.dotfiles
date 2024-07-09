-- telescope maps
local builtin = require('telescope.builtin')
require('telescope').load_extension "file_browser"

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>fe', ':Telescope file_browser<cr>', { noremap = true })

-- cutlass maps
vim.keymap.set("x", "x", "d")
vim.keymap.set("n", "xx", "dd")
vim.keymap.set("x", "X", "D")

-- subversive maps

-- s for substitute
vim.keymap.set("n", "s", "<Plug>(SubversiveSubstitute)")
vim.keymap.set("n", "ss", "<Plug>(SubversiveSubstituteLine)")
vim.keymap.set("n", "S", "<Plug>(SubversiveSubstituteToEndOfLine)")

-- substitute range maps
vim.keymap.set("n", "<leader>s", "<Plug>(SubversiveSubstituteRange)") 
vim.keymap.set("x", "<leader>s", "<Plug>(SubversiveSubstituteRange)") 
vim.keymap.set("n", "<leader>ss", "<Plug>(SubversiveSubstituteWordRange)") 

vim.keymap.set("n", "<leader>cs", "<Plug>(SubversiveSubstituteRange)") 
vim.keymap.set("x", "<leader>cs", "<Plug>(SubversiveSubstituteRange)") 
vim.keymap.set("n", "<leader>css", "<Plug>(SubversiveSubstituteWordRange)") 

-- yanky.nvim mappings are here

vim. keymap.set({"n", "x"}, "y", "<Plug>(YankyYank)") -- yank
-- ring maps
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)") -- Put yanked text after cursor
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)") -- Put yanked text before cursor

vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)") -- Put yanked text after selection
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)") -- Put yanked text before selection

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)") -- Select previous entry through yank history
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)") -- Select previous entry through yank history 

-- unimpaired-like put maps
vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)") -- Put indented after cursor (linewise)
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)") -- Put indented before cursor (linewise)
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)") -- Put indented after cursor (linewise)
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)") -- Put indented before cursor (linewise))

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)") -- Put and indent right
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)") -- Put and indent left
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)") -- Put before and indent right
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)") -- Put before and indent left

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)") -- Put after applying a filter
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)") -- Put before applying a filter

-- nvim-cmp mappings are here
local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- use ctrl and jk to go through completion list
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), --use ctr and bf to scroll the documentation in cmp
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- force the completion menu to show up
        ["<C-e>"] = cmp.mapping.abort(), -- hide the completion menu
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
    })
})
