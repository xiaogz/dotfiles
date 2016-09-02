set nocompatible
"it's vim's package manager
call plug#begin('~/.vim/plugged')

" vim plugged 
Plug 'Yggdroot/indentLine'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'jelera/vim-javascript-syntax'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes \| ./install'}
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'lervag/vimtex'
call plug#end()

syntax on
filetype plugin indent on

" sets vim's indentation char to be `
let g:indentLine_char = '`' 

" sets ycm_extra_conf location
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/ycm_extra_conf.py'

" close preview window after ycm auto-completion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" disables security warning when loading the ycm_extra_conf
let g:ycm_confirm_extra_conf = 0
" lets ycm populate vim location list with diagnostic data,
"   enabling jumping to error with ":lnext" and ":lprevious"
let g:ycm_always_populate_location_list = 1



" only enable ycm for these file types
let g:ycm_filetype_whitelist = {
  \ 'h': 1,
  \ 'hpp': 1,
  \ 'cpp': 1,
  \ 'cc': 1,
  \ 'c': 1,
  \ 'hh': 1
  \}

syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set lbr 
set formatoptions+=1
"these 2 options forces whole word wraps

" stuff for george files used in SE212
autocmd BufNewFile,BufRead *.grg setlocal shiftwidth=3

nnoremap j gj
nnoremap k gk
nnoremap <silent> <Space> :nohlsearch <CR>
set hlsearch
:nohlsearch
set incsearch
set expandtab
set shiftwidth=2
set tabstop=2
" I don't want vim to automatically hardwrap everything for me
set tw=0 
set laststatus=2 
" display current absolute line number
set number  
" display relative line numbers elsewhere
set relativenumber
" even with multi-line wrap and 'j'/'k' mapped, relative line jumping
" isn't affected and will consider wrapped lines as a single line
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

set showcmd 
" Show command while inputting
set smarttab
set scrolloff=5
" let loaded_matchparen = 1
" above disables loading of parenthesis matching standard plugin
set autoindent
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
set mouse=ar mousemodel=extend 
"makes cursor go to left-click's position and enable drag-selection  
"show possible completions
set wildmenu
"split down and to the right
set splitright
set splitbelow
"allow case-insensitive tab completion
set smartcase
set ignorecase
"highlight current line
set cursorline

"disable LaTeX symbol conversion
let g:tex_conceal = ""

