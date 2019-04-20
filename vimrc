set nocompatible
"it's vim's package manager
call plug#begin('~/.vim/plugged')

" vim plugged
Plug 'Yggdroot/indentLine'
Plug 'vim-perl/vim-perl'
Plug 'craigemery/vim-autotag'
Plug 'octol/vim-cpp-enhanced-highlight'
" for fancy start screens
Plug 'mhinz/vim-startify'
Plug 'jelera/vim-javascript-syntax'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes \| ./install'}
" Tabular for aligning text on equal sign
Plug 'godlygeek/tabular'
Plug 'alisdair/vim-armasm'
Plug 'altercation/vim-colors-solarized'
" html auto close tag
Plug 'alvan/vim-closetag'
" html % traversal
Plug 'tmhedberg/matchit'
"Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
"this lets vimplug load YCM but won't update it
Plug '~/.vim/plugged/YouCompleteMe', {'do': './install.py --clang-completer'}
" ycm config generator to let ycm know about specific make and library setups
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" rust syntax
Plug 'rust-lang/rust.vim'
Plug 'lervag/vimtex', { 'for': 'tex' }
" Git plugin that shows changed lines in file
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()

filetype plugin indent on
syntax on

" settings for alvan/vim-closetag
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_filenames = '*.html'
let g:closetag_shortcut = '>'
" can also use :CloseTagToggle/Enable/DisableBuffer to enable this feature for current buffer

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
" possible solution to ycm slowing down vim
let g:ycm_collect_identifiers_from_tags_files = 0

" allow local .vimrc settings to override this one
set exrc

" only enable ycm for these file types
let g:ycm_filetype_whitelist = {
  \ 'h': 1,
  \ 'hpp': 1,
  \ 'cpp': 1,
  \ 'cc': 1,
  \ 'c': 1,
  \ 'hh': 1,
  \ 'mm': 1,
  \ 'metal': 1
  \}

syntax enable
set background=light
colorscheme solarized

" for craigemery/vim-autotag options
let g:autotageTagsFile="tags"
set tags=./tags,tags;$HOME

"these 2 options forces whole word wraps
set lbr
set formatoptions+=1

" disable hardwrap
set tw=0

" remap the horrendously slow sql completion stuff away from <C-c>
let g:omni_sql_no_default_maps = 1
let g:ftplugin_sql_omni_key = '<C-*>'

" macro for html navigation
runtime macros/machit.vim

" for working with Metal files
augroup Metal
  autocmd!
  autocmd BufNewFile,BufRead *.metal setlocal filetype=cpp
  autocmd BufNewFile,BufRead *.mm setlocal filetype=cpp
  autocmd BufNewFile,BufRead *.cl setlocal filetype=c
  autocmd BufNewFile,BufRead *.cu setlocal filetype=c
augroup END

" wanted to disable .tbl contents being considered for autocompletion but left
" as TODO; temp solution is to unload .tbl in buffer
"augroup SQL
"  autocmd!
"  autocmd BufNewFile,BufRead *.tbl setlocal complete=
"augroup END

augroup YAML
  autocmd!
  autocmd BufNewFile,BufRead *.yaml setlocal expandtab tabstop=2 shiftwidth=2
augroup END

augroup Java
  autocmd!
  autocmd BufNewFile,BufRead *.java setlocal expandtab tabstop=2 shiftwidth=2
augroup END

" enable function highlighting for java files (dunno if string matters as long as it's different than 'indent'; this highlights too much extra stuff
"let java_highlight_functions="indent"

" for working with GLSL files (CS488)
augroup GLSL
  autocmd!
  autocmd BufNewFile,BufRead *.fs setlocal filetype=c
  autocmd BufNewFile,BufRead *.vs setlocal filetype=c
augroup END

" for working with ARM assembly
augroup ARMASM
  autocmd!
  autocmd BufNewFile,BufRead *.s setlocal filetype=armasm
augroup END

" for working with web stuff
augroup Web
  autocmd!
  autocmd FileType html setlocal shiftwidth=2 tabstop=2
  autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
  autocmd FileType css setlocal shiftwidth=2 tabstop=2
augroup END

" change tab settings when opening python files
augroup Python
  autocmd!
  autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
augroup END

" change tab size for latex files
augroup LaTeX
  autocmd!
  autocmd FileType tex setlocal expandtab tabstop=2 shiftwidth=2
augroup END

" ensure that cursor in insert mode is pipe not block
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" set escape key delay to less
set timeoutlen=1000 ttimeoutlen=5
" map ctrl-c to escape
:ino <C-C> <Esc>

nnoremap dq 0D

" tagbar is for jumping to functions/classes within source code file
nnoremap <F8> :TagbarToggle<CR>
" Gblame to see git blame on line basis
nnoremap <F9> :Gblame<CR>
" Gstatus to see git status easily; 'cc' to call :Gcommit
nnoremap <F10> :Gstatus<CR>

" removes highlighted search results until next search
nnoremap <silent> zp :nohlsearch<CR>
set hlsearch
:nohlsearch

" let mousewheel scroll move screen not just cursor
set mouse=a

" turn off bad error msgs related to brackets
let c_no_curly_error=1

set incsearch
set expandtab
set shiftwidth=4
set tabstop=4

" make backspace work even against tabs like any other programs (mac-specific)
set backspace=2
"set backspace=indent,eol,start

" see trailing whitespaces (but not current working line during insert mode)
:highlight ExtraWhitespace ctermbg=lightgreen guibg=darkgreen
:match ExtraWhitespace /\s\+\%#\@<!$/
" remove trailing whitespace with mapped key
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" enable manual folding to speed up vim
set fdm=manual
" foldnestmax set to 5 levels max
set fdn=5
" but disable auto-folding when I open file
set foldlevelstart=99

" prevent gitgutter from mapping keys (I just want it for git diff lines)
let g:gitgutter_map_keys = 0

" make vim display file name
set laststatus=2
" make vim display fancy file info
" see :help statusline for explanations
" relative path, read-only & modified flag, percent left, line/total line
set statusline=%f\ \ %r%m\ \|%P\ %l/%L\ -\ %c\|
" display current absolute line number
set number
" display relative line numbers elsewhere
" disable for less slowdown
"set relativenumber

" helps with faster screen draws
set ttyfast
set lazyredraw

" even with multi-line wrap and 'j'/'k' mapped, relative line jumping
" isn't affected and will consider wrapped lines as a single line
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" improved mappings to scroll without moving cursor
noremap zu zt
noremap zj zz
noremap zm zb

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
" make vim consider all .tex files as latex, not plaintex, etc
let g:tex_flavor = "latex"
"diable vimtex verbose warning
let g:vimtex_disable_version_warning = 1

" temp syntax highlight debuggin
"map <F7> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
"\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
"\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

