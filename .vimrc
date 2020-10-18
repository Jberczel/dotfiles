syntax enable

set relativenumber
set ruler
set nowrap
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
set splitbelow
set splitright

" List chars
set list
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen
set belloff=all

let mapleader=","
inoremap jk <Esc>

nmap <leader>hs :set hlsearch! hlsearch?<CR>

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <silent> <leader>s :BLines<CR>

" Yank current word (yiw), then run rip grep and paste current word (<C-R>"),
" and run command
nnoremap <leader>a yiw :Rg <C-R>"<CR>
vnoremap <leader>a y :Rg <C-R>0<CR>

" Add preview to ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg -g "!releases/*" -g "!test/*" -g "!doc/*" --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>1)


call plug#begin('~/.vim/plugged')

  Plug 'airblade/vim-gitgutter'

  " <Leader>n -> toggle NerdTree
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }


  " vim-surround examples:
  " cs"' -> change surrounding 
  " yss[ -> add surrounding bracket to line
  " ysiw] -> add surrounding brack (no space) to word
  " ys2w  -> add quotes to two words: 'Launch Wizard'
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

  " gv examples:
  " :GV  => something
  " :GV! => something
  Plug 'junegunn/gv.vim'

  Plug 'terryma/vim-multiple-cursors'

  " COLORS
  Plug 'https://github.com/junegunn/seoul256.vim.git'
  Plug 'morhetz/gruvbox'
    let g:gruvbox_contrast_dark = 'soft'

  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'   }
  Plug 'preservim/nerdcommenter'

  Plug 'slim-template/vim-slim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'andrewradev/splitjoin.vim'
  Plug 'dense-analysis/ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" Toggle Color Themes
colorscheme gruvbox
" colo seoul256
" colo seoul256-light

" Toggle these two
" set background=light
set background=dark

" NERDTree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>n :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>


" delete current buffer
noremap <leader>x :bp<cr>:bd #<cr>

" Easy Align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Ruby Runner
" Sets filetype for ruby runner
command! FR set filetype=ruby
let g:RubyRunner_keep_focus_key ="false"
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

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
nnoremap <silent> <c-k> :move-2<cr>
nnoremap <silent> <c-j> :move+<cr>
nnoremap <silent> <c-h> <<
nnoremap <silent> <c-l> >>
xnoremap <silent> <c-k> :move-2<cr>gv
xnoremap <silent> <c-j> :move'>+<cr>gv
xnoremap <silent> <c-h> <gv
xnoremap <silent> <c-l> >gv
xnoremap < <gv
xnoremap > >gv

" Stop accidently recording
noremap <Leader>q q
noremap q <Nop>

" ===== Seeing Is Believing =====
" Assumes you have a Ruby with SiB available in the PATH
" If it doesn't work, you may need to `gem install seeing_is_believing`

function! WithoutChangingCursor(fn)
  let cursor_pos     = getpos('.')
  let wintop_pos     = getpos('w0')
  let old_lazyredraw = &lazyredraw
  let old_scrolloff  = &scrolloff
  set lazyredraw

  call a:fn()

  call setpos('.', wintop_pos)
  call setpos('.', cursor_pos)
  redraw
  let &lazyredraw = old_lazyredraw
  let scrolloff   = old_scrolloff
endfun

function! SibAnnotateAll(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk"]))
endfun

function! SibCleanAnnotations(scope)
  call WithoutChangingCursor(function('execute', [a:scope . "!seeing_is_believing --clean"]))
endfun

" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  " clear the settings if they already exist (so we don't run them twice)
  autocmd!
  autocmd FileType ruby nmap <buffer> <Leader>R :call SibAnnotateAll("%")<CR>;
  autocmd FileType ruby nmap <buffer> <Leader>C :call SibCleanAnnotations("%")<CR>;
augroup END

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

