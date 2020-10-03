syntax enable

set number
set ruler
set nowrap
" set colorcolumn=80

set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start

set showcmd
set cursorline
set laststatus=2

set hlsearch
set incsearch
set ignorecase

" List chars
set list
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

set splitbelow
set splitright

let mapleader=","

nmap <leader>hs :set hlsearch! hlsearch?<CR>

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" Yank current word (yiw), then run rip grep and paste current word (<C-R>"),
" and run command
nnoremap <leader>a yiw :Rg <C-R>"<CR>

" Add preview to ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg -g "!releases/*" -g "!test/*" -g "!doc/*" --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>1)

inoremap jk <Esc>

call plug#begin('~/.vim/plugged')

  Plug 'airblade/vim-gitgutter'

  " <Leader>n -> toggle NerdTree
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

  Plug 'ntpeters/vim-better-whitespace'

  " vim-surround examples:
  " cs"' -> change surrounding 
  " yss[ -> add surrounding bracket to line
  " ysiw] -> add surrounding brack (no space) to word
  " ds{  -> delete surrounding brace
  " S"   -> in Visual Mode, add surround quotes
  Plug 'tpope/vim-surround'

  " Automatically adds 'end' to methods
  Plug 'tpope/vim-endwise'

  " :Git (or just :G) calls any Git command
  " :Git blame, :Git diff, :Git log
  Plug 'tpope/vim-fugitive'

  " Execute ruby from Vim
  " <Leader>r
  Plug 'henrik/vim-ruby-runner'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
  Plug 'junegunn/fzf.vim'

  " vim-easy-align examples:
  " gaip<Enter>=
  Plug 'junegunn/vim-easy-align'

  " Color theme
  Plug 'https://github.com/junegunn/seoul256.vim.git'

  Plug 'slim-template/vim-slim'

  " gv examples:
  " :GV  => something
  " :GV! => something
  Plug 'junegunn/gv.vim'

  Plug 'terryma/vim-multiple-cursors'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'   }
  Plug 'justinmk/vim-sneak'
  Plug 'preservim/nerdcommenter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'dense-analysis/ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


colo seoul256
colo seoul256-light

" Toggle these two
set background=light
set background=dark

" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>n :NERDTreeToggle<CR>

let loaded_netrwPlugin = 1

" Easy Align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Ruby Runner
" Sets filetype for ruby runner
command! FR set filetype=ruby
" Default ruby runner config
" let g:RubyRunner_key = '<Leader>r'
let g:RubyRunner_open_below = 1
let g:RubyRunner_window_size = 10

" folding settings
" set foldmethod=indent
" set foldlevel=2
" set foldclose=all
set nofoldenable    " disable folding

" Enable with :ALEToggle
let g:ale_enabled = 0

augroup dryml_ft
  au!
  autocmd BufNewFile,BufRead *.dryml   set syntax=xml
augroup END


