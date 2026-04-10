return {
  {
      "olimorris/codecompanion.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("codecompanion").setup({
          strategies = {
            chat = { adapter = "big_brain" },
            inline = { adapter = "big_brain" },
          },
          adapters = {
            -- NEW: Adapters are now nested by protocol (http or acp)
            http = {
              big_brain = function()
                return require("codecompanion.adapters").extend("ollama", {
                  -- CRITICAL: The name property must match the key 'big_brain'
                  name = "big_brain", 
                  schema = {
                    model = {
                      default = "qwen3:32b", -- Ensure you've run 'ollama pull qwen3:32b'
                    },
                    -- 2026 Update: Qwen3 models often require higher context windows
                    num_ctx = { default = 32768 },
                  },
                })
              end,
            },
          },
        })

        -- Keymap
        vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
      end,
  },
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('minuet').setup({
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 512,
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name="Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = 'qwen2.5-coder:1.5b',
          },
        },
        virtualtext = {
          auto_trigger_ft = { 'python', 'javascript' },
          keymap = {
            accept = "<Right>", -- Alt-a to accept suggestion
            next = "<A-n>",   -- Alt-n to see next option
          },
        },
      })
    end
  }
}
