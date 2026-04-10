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

--diag view window
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 5,
  },

  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
-- diag icons config
local function setup_diagnostic_icons()
    -- 1. Define icons using severity constants
    local icons = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "󰀪 ",
        [vim.diagnostic.severity.HINT]  = "󰌵 ",
        [vim.diagnostic.severity.INFO]  = "󰋽 ",
    }

    -- 2. Use the native diagnostic configuration table
    vim.diagnostic.config({
        signs = {
            text = icons,
            -- Optional: apply the highlight group to the line number as well
            numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticLogError",
                -- etc...
            },
        },
    })
end

-- Call it directly
setup_diagnostic_icons()
