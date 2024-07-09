local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end
require('config.plugins')

load('config.settings')
load('config.commands')
load('config.keymaps')

pcall(vim.cmd.colorscheme, 'tokyonight')
