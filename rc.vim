set nocompatible

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/powerline'
Bundle 'vim-scripts/taglist.vim'
Bundle 'scrooloose/syntastic'
Bundle 'airblade/vim-gitgutter'
Bundle 'ervandew/supertab'

" Language support
Bundle 'Rip-Rip/clang_complete'
Bundle 'wlangstroth/vim-haskell'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'scala/scala-dist', {'rtp': 'tool-support/src/vim'}
Bundle 'vim-scripts/VimClojure'

set background=dark
set t_Co=256
colorscheme bubblegum
" hide the gui menubar
if has('gui_running')
  set guioptions=egmrt  
endif

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent

au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
au BufRead,BufNewFile *.rb  set textwidth=80
au BufRead,BufNewFile *.js  set textwidth=80
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

filetype off
syntax on
filetype plugin indent on

" Fix OSX backspacing
set backspace=indent,eol,start

set spelllang=en_us
set nospell
nmap <silent> <leader>s :set spell!<CR>

" nice searching
set ignorecase
set smartcase

set ruler nu 

set showcmd

set hlsearch
set incsearch

set noerrorbells

" Word wrap w/o line breaks
set wrap
set linebreak
set list
set nostartofline

" Nicer autocomplete commands
set wildmode=longest:full
set wildmenu

" Screw backups
set nobackup nowritebackup noswapfile

set colorcolumn=+1
set clipboard=unnamed

set fileformats=unix,dos,mac
scriptencoding utf-8
set encoding=utf-8

set history=100000

" Use and toggle mouse
set mouse=a
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    set nonumber
    echo "Mouse usage disabled"
  else
    set mouse=a
    set number
    echo "Mouse usage enabled"
  endif
endfunction

nmap <silent> <leader>c :call ToggleMouse()<CR>

" Make tabs super visible
execute "set listchars=tab:" . nr2char(187) . '\ '

" folds!
set foldenable
set foldmethod=indent
set foldnestmax=2
set foldlevel=1
set foldlevelstart=1
set foldminlines=2
set fillchars=vert:\|,fold:\
map <Leader>f zR
" Toggle folds with space
fu! ToggleFold()
   if foldlevel('.') == 0
       normal! l
   else
       if foldclosed('.') < 0
           . foldclose
       else
           . foldopen
       endif
   endif
   echo
endf
noremap <space> :call ToggleFold()<CR>

" Re-highlight after Indent/unindent
vmap < <gv
vmap > >gv

" Emacs!
imap <C-a> <Esc>I
imap <C-e> <Esc>A
 
" Systastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_loc_list_height=5
let g:syntastic_always_populate_loc_list=1
map <Leader><Tab> :Errors<CR>

" eclim stuff
map <Leader>d <ESC>:JavaSearch -p <C-R><C-W> -x declarations<CR>
map <Leader>i <ESC>:JavaSearch -p <C-R><C-W> -x implementations<CR>
map <Leader>r <ESC>:JavaSearch -p <C-R><C-W> -x references<CR>
map <Leader>j <ESC>:JavaSearchContext<CR>

map <Leader>D <ESC>:JavaSearch -x declarations -p  
map <Leader>I <ESC>:JavaSearch -x implementations -p 
map <Leader>R <ESC>:JavaSearch -x references -p 
nmap , :nohlsearch<CR>

" CtrlP
map <Leader>b <ESC>:CtrlPBuffer<CR>
map <Leader><Space> <ESC>:CtrlPMRUFiles<CR>
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.o,*.so,*.swp,*.zip,*.jar,*.class,*.pdf,*.gif,*.png,*.jpg
let g:ctrlp_custom_ignore = '\v[\/](_build|(\.(git|hg|svn)))$'
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 0

" Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2   " Always show the statusline
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Taglist
map <silent> <Leader>t :TlistToggle<CR>
