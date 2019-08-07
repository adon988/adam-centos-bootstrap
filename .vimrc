set encoding=utf-8
set fileencodings=utf-8,cp950
set nocompatible              " be iMproved, required
set hidden
filetype plugin indent on                  " required
set autoindent
set foldmethod=syntax
set foldlevel=20
set wrap linebreak nolist
set clipboard+=unnamed
set shell=sh

execute pathogen#infect()
nnoremap <silent> <F5> :NERDTree<CR>
let NERDTreeShowHidden=1

set cursorline!
set lazyredraw
set synmaxcol=256
syntax sync minlines=256

set nowrap
xnoremap p pgvy

syntax on
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set nu

set ruler
set backspace=2
set ic
set ru
set hlsearch
set incsearch
set smartindent
set confirm
set history=100
set cursorline

set sidescroll=1
set sidescrolloff=3

let mapleader = ","

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
  set termguicolors
else
  set termguicolors
endif

set linespace=5

if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif"

let g:jsx_ext_required = 0
let g:rubycomplete_buffer_loading = 1

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif


Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'gavocanov/vim-js-indent'
Plug 'kchmck/vim-coffee-script'
Plug 'posva/vim-vue'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_tags_command = 'ctags -R'
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'

  nnoremap <silent> <C-p> :Files<CR>
  nnoremap <silent> <C-b> :Buffers<CR>
  nnoremap <silent> <leader>bn :bn<CR>
  nnoremap <silent> <leader>bp :bp<CR>
  nnoremap <silent> <leader>w :Windows<CR>
  nnoremap <silent> <leader>l :BLines<CR>
  nnoremap <silent> <leader>t :BTags<CR>
  nnoremap <silent> <leader>T :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <leader>f :AgIn

  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <leader>gc :Commits<CR>
  nnoremap <silent> <leader>gb :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <C-x><C-j> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction

  function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
  endfunction
  command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Type'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Identifier'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  let g:fzf_history_dir = '~/.local/share/fzf-history'

  function! s:fzf_statusline()
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction

  autocmd! User FzfStatusLine call <SID>fzf_statusline()

Plug 'chrisbra/csv.vim'
let g:csv_autocmd_arrange = 1

Plug 'scrooloose/nerdtree'
nnoremap <silent><C-\> :NERDTreeToggle<CR>

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-ruby/vim-ruby'
let g:ruby_indent_access_modifier_style = 'indent'
let ruby_operators = 1
let ruby_fold = 1

Plug 'elixir-lang/vim-elixir'

Plug 'tpope/vim-rails'
let g:rails_ctags_arguments = ['--languages=ruby --exclude=.git --exclude=log .']

Plug 'ecomba/vim-ruby-refactoring', { 'for': 'ruby' }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'

Plug 'oguzbilgic/sexy-railscasts-theme'
Plug 'rakr/vim-one'
Plug 'dracula/vim'
Plug 'hzchirs/vim-atom-material'
let g:gruvbox_italic=1

Plug 'chrisbra/Colorizer'

Plug 'sheerun/vim-polyglot'

Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
nmap ga <Plug>(EasyAlign)

Plug 'editorconfig/editorconfig-vim'
Plug 'rizzatti/dash.vim'
nnoremap <silent><leader>d :Dash<CR>

Plug 'tpope/vim-surround'

Plug 'Yggdroot/indentLine'
let g:indentLine_setColors = 1
let g:indentLine_enabled = 0
nnoremap <silent><leader>ig :IndentLinesToggle<CR>


Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_toc_autofit      = 1
let g:vim_markdown_frontmatter      = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

if has('nvim')
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  let g:deoplete#enable_at_startup = 1
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  let g:deoplete#max_list = 6
  inoremap <silent> <CR> <C-r>=<SID>return_without_deoplete()<CR>
  function! s:return_without_deoplete() abort
    return deoplete#mappings#close_popup() . "\<CR>"
  endfunction
endif

Plug 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

Plug 'Konfekt/FastFold'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-commentary'


if !has('gui_running')
Plug 'ryanoasis/vim-devicons'
endif

call plug#end()

nnoremap <silent><leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent><leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
if has('nvim')
  nmap <BS> <C-W>h
endif

nmap <C-S> :update<CR>
vmap <C-S> <C-C>:update<CR>
imap <C-S> <C-O>:update<CR><Right>

set laststatus=2
set background=dark

let g:airline_theme="one"
highlight Search guibg=NONE guifg=NONE gui=underline

function! SynStack()
    if !exists('*synstack')
        return
    endif
    echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
endfunc
nmap <leader><leader>x :call SynStack()<CR>
