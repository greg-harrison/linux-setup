set nocompatible
set background=dark

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent

au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.js  set textwidth=80
au BufRead,BufNewFile *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
au BufRead,BufNewFile *.js  setlocal iskeyword+=.
au BufRead,BufNewFile *.tex  setlocal iskeyword+=_
au BufRead,BufNewFile *.rb  set textwidth=80

autocmd bufwritepost .vimrc source $MYVIMRC " auto-source .vimrc

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete

set backspace=indent,eol,start

set spelllang=en_us
set nospell

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
set nolist

set wildmode=longest:full
set wildmenu

set tags=./tags,tags
filetype plugin indent on
set mouse=a

" Make \t super visible
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

" Map this function to Space key.
  noremap <space> :call ToggleFold()<CR>

set t_Co=256
colorscheme wombat256

if has('gui_macvim')
  set transparency=0 
  set guioptions-=T
endif

set nobackup nowritebackup noswapfile

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype off
syntax on
filetype plugin indent on

if v:version >= 700
  set colorcolumn=+1
  hi ColorColumn guibg=#2d2d2d ctermbg=246
endif

if v:version >= 730
  set clipboard+=unnamed
endif

set fileformats=unix,dos,mac
scriptencoding utf-8
set encoding=utf-8

set clipboard=unnamed

set history=1000

" Leader key mappings
nmap <silent> <leader>s :set spell!<CR>
map <silent> <Leader>t :TlistToggle<CR>

" Re-highlight after Indent/unindent
vmap < <gv
vmap > >gv

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

" Session stuff
nmap SQ <ESC>:mksession! ~/.vim/Session.vim<CR>:wqa<CR>
nmap SS <ESC>:mksession! ~/.vim/Session.vim<CR>
nmap SO <ESC>:so ~/.vim/Session.vim<CR>
nmap SAS :wa<CR>:mksession! ~/sessions/
nmap SAO :wa<CR>:so ~/sessions/
 
" New tabs lol
map <silent> <C-N> :tabedit<CR>
" Tab switching
map <silent><C-j> <ESC>:tabnext<CR>
map <silent><C-k> <ESC>:tabprevious<CR>
nnoremap <silent> <C-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-l> :execute 'silent! tabmove ' . tabpagenr()<CR>

" resize panes
if bufwinnr(1)
  map <Leader>] <C-W><<ESC>
  map <Leader>[ <C-W>>
  map <Leader>- <C-W>-
  map <Leader>= <C-W>+
endif

" Systastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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
set encoding=utf-8 " Necessary to show unicode glyphs
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
let g:Powerline_symbols = 'fancy'
if has('gui_running')
  set guioptions=egmrt  " hide the gui menubar
endif
