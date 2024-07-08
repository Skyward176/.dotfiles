-- Basic vim settings
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.number= true
vim.o.completeopt='menu,menuone,noselect'
vim.g.mapleader = ' '

-- make yoink play with cutlass
vim.g.yoinkIncludeDeleteOperations = 1

-- custom text objects
vim.keymap.set("o", "ie", "<cmd>normal! ggVG<CR>")
vim.keymap.set("o", "iv", "<cmd>normal! HVL<CR>")

vim.g.startify_custom_header = {
    [[  .__   __.  _______   ______   ____    ____  __  .___  ___.]],
    [[  |  \ |  | |   ____| /  __  \  \   \  /   / |  | |   \/   | ]],
    [[  |   \|  | |  |__   |  |  |  |  \   \/   /  |  | |  \  /  |]],
    [[  |  . `  | |   __|  |  |  |  |   \      /   |  | |  |\/|  |]],
    [[  |  |\ \ | |  |____ |  `--'  |    \\   /    |  | |  |  |  |]],
    [[  |__| \__| |_______| \______/      \__/     |__| |__|  |__|]]
}
