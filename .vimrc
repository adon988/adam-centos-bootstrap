" 檔案編碼
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

" mouse scroll smooth
set cursorline!
set lazyredraw
set synmaxcol=256
syntax sync minlines=256

" 禁止过长的行回绕（超过屏幕宽度）
set nowrap
" paste without replace
xnoremap p pgvy

" 編輯喜好設定                                                                                                                                                                                                     
syntax on        " 語法上色顯示
" set ai           " 自動縮排
set shiftwidth=2 " 設定縮排寬度 = 4 
set tabstop=2    " tab 的字元數
set softtabstop=2
set expandtab   " 用 space 代替 tab
set nu          " Show line number
 
set ruler        " 顯示右下角設定值
set backspace=2  " 在 insert 也可用 backspace
set ic           " 設定搜尋忽略大小寫
set ru           " 第幾行第幾個字
set hlsearch     " 設定高亮度顯示搜尋結果
set incsearch    " 在關鍵字還沒完全輸入完畢前就顯示結果
set smartindent  " 設定 smartindent
set confirm      " 操作過程有衝突時，以明確的文字來詢問
set history=100  " 保留 100 個使用過的指令
set cursorline   " 顯示目前的游標位置

" 水平滾動順滑
set sidescroll=1
set sidescrolloff=3

let mapleader = ","

" 開啟 NVIM 專用選項
if has('nvim')
  " 允许真彩显示
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  " 允许光标变化
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
" let g:jsx_pragma_required = 1
let g:rubycomplete_buffer_loading = 1
" let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails = 1
" let g:rubycomplete_load_gemfile = 1

if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif


Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'gavocanov/vim-js-indent'
Plug 'kchmck/vim-coffee-script'
" Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
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
execute pathogen#infect()

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

  " In Neovim, you can set up fzf window using a Vim command
  " let g:fzf_layout = { 'window': 'enew' }
  " let g:fzf_layout = { 'window': '-tabnew' }

  " Customize fzf colors to match your color scheme
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

  " Enable per-command history.
  " CTRL-N and CTRL-P will be automatically bound to next-history and
  " previous-history instead of down and up. If you don't like the change,
  " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
  let g:fzf_history_dir = '~/.local/share/fzf-history'

  function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction

  autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}
Plug 'chrisbra/csv.vim'
let g:csv_autocmd_arrange = 1

Plug 'scrooloose/nerdtree'
nnoremap <silent><F5> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
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

" Themes
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

" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'

" Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
let g:indentLine_setColors = 1
let g:indentLine_enabled = 0
nnoremap <silent><leader>ig :IndentLinesToggle<CR>

" Run your favorite search tool from Vim, with an enhanced results list.
" Plug 'mileszs/ack.vim'
" let g:ackprg = 'ag --nogroup --nocolor --column'
" map <Leader>a :Ack! ''<Left>

" Markdown
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
  " Use deoplete.
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  let g:deoplete#enable_at_startup = 1
  " deoplete tab-complete
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
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Speed up folding
Plug 'Konfekt/FastFold'

" Fugitive: Git 集成，强烈推荐！
Plug 'tpope/vim-fugitive'

" Commentary: 快速注释。
Plug 'tpope/vim-commentary'

" Plug 'jeetsukumaran/vim-buffergator'

" if has('nvim')
if !has('gui_running')
Plug 'ryanoasis/vim-devicons'
endif
" set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline\ Nerd\ Font\ Complete:h16

call plug#end()

"======= 自訂
" 縮放視窗
nnoremap <silent><leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent><leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" buffer 移動
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
" TODO NeoVim issue, uncomment this and remove nmap <BS> <C-W>h after upgrade
" map <C-h> <C-W>h 
map <C-l> <C-W>l
if has('nvim')
  " Hack to get C-h working in NeoVim
  nmap <BS> <C-W>h
endif

" 儲存
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