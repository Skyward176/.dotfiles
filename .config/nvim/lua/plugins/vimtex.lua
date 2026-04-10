return {
  "lervag/vimtex",
  lazy = false, -- VimTeX must NOT be lazy-loaded; it needs to start with Neovim
  init = function()
    vim.g.vimtex_compiler_method = 'latexmk'

    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-shell-escape', -- Required if you use the 'minted' package for code highlighting
        '-verbose',
        '-file-line-error',
        '-synctex=1',    -- Essential for Forward/Backward search
        '-interaction=nonstopmode',
      },
    }
  end
}

