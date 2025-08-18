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
if system('defaults read -g AppleInterfaceStyle 2>/dev/null') == "Dark"
  set bg=dark
else
  set bg=light
endif

" set background to be light in ZED
if !empty($ZED_TERM)
  set bg=light
endif

" set maxmempattern higher
set mmp=2000
" use solarized color scheme
if empty($ZED_TERM)
  colorscheme solarized
endif

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
