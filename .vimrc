syntax on
" show line numbers
set number
" set text width 80 - auto wrap
set textwidth=80
" set color column at 80
set cc=80
" Always show statusline
set laststatus=2
" show file name (full) in status line
set statusline=%F
" Use 256 colours
set t_Co=256
" set background to be dark
set bg=dark
" set maxmempattern higher
set mmp=2000
" use solarized color scheme
colorscheme solarized

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" install plug.vim via:
" $ curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
