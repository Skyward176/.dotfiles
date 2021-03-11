call plug#begin()
Plug 'preservim/NERDTree'
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'mhinz/vim-startify'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'ryanoasis/vim-devicons'
Plug 'posva/vim-vue'
Plug 'https://github.com/tpope/vim-commentary.git'
call plug#end()

"color scheme stuff
set termguicolors

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

colorscheme tokyonight
let g:airline_theme = "tokyonight"
"more general stuff

syntax enable
set tabstop=4
set softtabstop=4
set expandtab
set number

filetype indent on
set showmatch

set incsearch
set hlsearch

autocmd BufWritePre * %s/\s\+$//e

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd= 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'
" ctrl space config stuff
set nocompatible
set hidden
set encoding=utf-8
nnoremap <C-t> :NERDTreeToggle<CR>
" If another buffer tries to replace NERDTree, put it in the other window, and
" bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
"auto source vimrc
au! BufWritePost $MYVIMRC source %

"utf-8 charset
set encoding=utf-8
