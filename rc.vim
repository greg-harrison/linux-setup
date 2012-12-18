set nocompatible
set background=dark

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent smartindent cindent


let g:SuperTabMappingBackward = '<c-s-tab>'
let g:SuperTabDefaultCompletionType = "<C-N>"

au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.js  set textwidth=80
au BufRead,BufNewFile *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
au BufRead,BufNewFile *.js  setlocal iskeyword+=.

au BufRead,BufNewFile *.tex  setlocal iskeyword+=_

autocmd bufwritepost .vimrc source $MYVIMRC " auto-source .vimrc

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType c set omnifunc=ccomplete#Complete
  
" au FileType java let g:SuperTabDefaultCompletionType = "<C-X, C-U>"

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
" Ignore useless files from command-t searches
set wildignore+=*.o,*.obj,.git,*.pdf,*.png,*.jpg,*.tiff,tools,gen

set backspace=indent,eol,start

set spelllang=en_gb
set spell

set ruler nu 
set showcmd hlsearch incsearch noerrorbells
set list

set wildmode=longest:full
set wildmenu

set tags=./tags,tags
filetype plugin indent on
set mouse=a

"set cursorline cursorcolumn

runtime! macros/matchit.vim

execute "set listchars=tab:" . nr2char(187) . '\ '

set foldmethod=indent foldnestmax=10 nofoldenable foldlevel=1 

set t_Co=256
colorscheme wombat256

if has('gui_macvim')
  set transparency=0 
  set guioptions-=T
  "colorscheme ir_black
endif

cmap w!! w !sudo tee % >/dev/null

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

set clipboard=unnamed

set history=1000


" Leader key mappings
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>m :w<ENTER>:make<CR>
nmap <silent> <leader>f :w<ENTER>:!fixjsstyle %<ENTER>:e! %<CR>

" Indent/unindent
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Tab switching for MacVim
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" Indent/unindent
nmap <M-[> <<
nmap <M-]> >>
vmap < <gv
vmap > >gv

" Tab switching for Linux
map <M-S-]> gt
map <M-S-[> gT
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt
map <M-0> :tablast<CR>

map <silent> <Leader>t :TlistToggle<CR>
map <silent> <C-N> :tabedit<CR>

nmap <silent> <leader>c :call ToggleMouse()<CR>
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

"imap <tab> <Plug>SuperTabForward
"imap <s-tab> <Plug>SuperTabBackward

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

set ignorecase
set smartcase
set guioptions=menu

" Session stuff
nmap SQ <ESC>:mksession! ~/.vim/Session.vim<CR>:wqa<CR>
nmap SS <ESC>:mksession! ~/.vim/Session.vim<CR>
nmap SO <ESC>:so ~/.vim/Session.vim<CR>
nmap SAS :wa<CR>:mksession! ~/sessions/
nmap SAO :wa<CR>:so ~/sessions/
 
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

" eclim stuff
map <Leader>d <ESC>:JavaSearch -p <C-R><C-W> -x declarations<CR>
map <Leader>i <ESC>:JavaSearch -p <C-R><C-W> -x implementations<CR>
map <Leader>r <ESC>:JavaSearch -p <C-R><C-W> -x references<CR>
map <Leader>j <ESC>:JavaSearchContext<CR>

map <Leader>D <ESC>:JavaSearch -x declarations -p  
map <Leader>I <ESC>:JavaSearch -x implementations -p 
map <Leader>R <ESC>:JavaSearch -x references -p 
nmap , :nohlsearch<CR>

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=80 columns=120
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=80
  endif
endif

" CtrlP
map <Leader>b <ESC>:CtrlPBuffer<CR>
map <Leader><Space> <ESC>:CtrlPMRUFiles<CR>
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jar,*.class     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/](_build|(\.(git|hg|svn)))$'
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 0

" Powerline
set encoding=utf-8 " Necessary to show unicode glyphs
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
let g:Powerline_symbols = 'compatible'
if has('gui_running')
  set guioptions=egmrt  " hide the gui menubar
endif
set nospell
