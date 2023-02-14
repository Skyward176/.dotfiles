local jdtls = require('jdtls')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls-workspace') .. project_name

local root_markers = {'.git', 'mvnw', 'gradlew'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local config = {
    cmd = {
        'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '-jar', '/opt/homebrew/opt/jdtls/libexec/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', '/opt/homebrew/opt/jdtls/libexec/config_mac/',
                        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                        -- Must point to the                      Change to one of `linux`, `win` or `mac`
                        -- eclipse.jdt.ls installation            Depending on your system.


        '-data', workspace_dir,
    },
    root_dir,
    capabilities=capabilities
}
jdtls.start_or_attach(config)
