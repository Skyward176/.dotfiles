local Plugin = { 'echasnovski/mini.nvim', version = '*' }

Plugin.config = function()
    local starter = function()
	require('mini.starter').setup()
    end

    starter()
end

return Plugin
