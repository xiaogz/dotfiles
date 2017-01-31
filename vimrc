set nocompatible
"it's vim's package manager
call plug#begin('~/.vim/plugged')

" vim plugged
Plug 'Yggdroot/indentLine'
Plug 'vim-perl/vim-perl'
Plug 'craigemery/vim-autotag'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jelera/vim-javascript-syntax'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes \| ./install'}
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'lervag/vimtex'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
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
  \ 'hh': 1,
  \ 'mm': 1,
  \ 'metal': 1,
  \ 'dart': 1
  \}

syntax enable
set background=dark
colorscheme solarized

" for craigemery/vim-autotag options
let g:autotageTagsFile="tags"
set tags=./tags,tags;$HOME

set lbr
set formatoptions+=1
"these 2 options forces whole word wraps

" stuff for george files used in SE212
autocmd BufNewFile,BufRead *.grg setlocal shiftwidth=3

" for reading Metal files
autocmd BufNewFile,BufRead *.metal setlocal filetype=cpp
autocmd BufNewFile,BufRead *.mm setlocal filetype=cpp
autocmd BufNewFile,BufRead *.cl setlocal filetype=c
autocmd BufNewFile,BufRead *.cu setlocal filetype=c

" change tab settings when opening python files
autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4

nnoremap j gj
nnoremap k gk

noremap <F4> :NERDTreeToggle<ENTER>

" removes highlighted search results until next search
nnoremap <silent> zp :nohlsearch <CR>
set hlsearch
:nohlsearch

" let mousewheel scroll move screen not just cursor
set mouse=a

" turn off bad error msgs related to brackets
let c_no_curly_error=1

set incsearch
set expandtab
set shiftwidth=2
set tabstop=2

" make backspace work even against tabs like any other programs (mac-specific)
set backspace=2

" see trailing whitespaces (but not current working line during insert mode)
:highlight ExtraWhitespace ctermbg=lightgreen guibg=darkgreen
:match ExtraWhitespace /\s\+\%#\@<!$/

" remove trailing whitespace with mapped key
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" enable manual folding (foldmethod abbreviated to fdm);
set fdm=syntax
" but disable auto-folding when I open file
set foldlevelstart=99

" I don't want vim to automatically hardwrap everything for me
set tw=0
" make vim display file name
set laststatus=2
" make vim display fancy file info
" see :help statusline for explanations
" relative path, read-only & modified flag, percent left, line/total line
set statusline=%f\ \ %r%m\ \|%P\ %l/%L\ -\ %c\|
" display current absolute line number
set number
" display relative line numbers elsewhere
set relativenumber

" helps with faster screen draws
set ttyfast
set lazyredraw

" even with multi-line wrap and 'j'/'k' mapped, relative line jumping
" isn't affected and will consider wrapped lines as a single line
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" going to line # also vertically centers that line;
" but not in visual mode
nnoremap gg ggzz

" easily jump between splits
nnoremap <Space> <C-w>w

" 1-button tab jumps
nnoremap <tab> gt

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


