local Telescope = {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }  ,
        lazy=false
    }

Telescope.config = function ()
    local telescope = require('telescope')
    telescope.setup ({
        extensions = {
            file_browser = {

            },
            yank_history = {

            }
        }
    })
end
return Telescope
