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
-- ring maps
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- unimpaired-like put maps
vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

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
