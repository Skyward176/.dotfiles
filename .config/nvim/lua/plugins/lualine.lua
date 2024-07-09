local Plugin = {'nvim-lualine/lualine.nvim'}
Plugin.config = function()
    local lualine = require("lualine")
        lualine.setup({
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
        })
    end

return Plugin
