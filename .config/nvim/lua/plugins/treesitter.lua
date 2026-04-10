local Plugin = {"nvim-template/nvim-treesitter"} -- Note: Ensure this is the correct repo name
Plugin = {"nvim-treesitter/nvim-treesitter"}
Plugin.build = ":TSUpdate"
Plugin.config = function()
    -- CHANGE: We no longer require 'nvim-treesitter.configs'
    -- We use the main module or simply call setup on the plugin itself
    local ok, treesitter = pcall(require, "nvim-treesitter.configs")
    
    -- If the 'configs' module is missing (the cause of your error), 
    -- we fallback to the standard setup approach.
    if not ok then
        -- In the newest versions, you can often just use:
        -- require("nvim-treesitter").setup(...) 
        -- but most users find that the plugin manager handles the core.
        -- However, to fix your specific error, we use the following:
        treesitter = require("nvim-treesitter") 
    end

    treesitter.setup({
        ensure_installed = {'lua', 'java', 'python', 'javascript', 'c'},
        auto_install = true,
        highlight = {
            enable = true,
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            -- disable = function(lang, buf)
            --     local max_filesize = 100 * 1024 -- 100 KB
            --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            --     if ok and stats and stats.size > max_filesize then
            --         return true
            --     end
            -- end,
        } 
    })
end
return Plugin
