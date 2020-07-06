" vim: set foldmethod=marker foldlevel=0 nomodeline:
" =============================================================================
"            __
"           |  \
" __     __  \$$ ______ ____    ______    _______
"|  \   /  \|  \|      \    \  /      \  /       \
" \$$\ /  $$| $$| $$$$$$\$$$$\|  $$$$$$\|  $$$$$$$
"  \$$\  $$ | $$| $$ | $$ | $$| $$   \$$| $$
"   \$$ $$  | $$| $$ | $$ | $$| $$      | $$_____
"    \$$$   | $$| $$ | $$ | $$| $$       \$$     \
"     \$     \$$ \$$  \$$  \$$ \$$        \$$$$$$$
" ==============================================================================
let mapleader = "\<Space>"

" ==============================================================================
" vim-plug {{{
" ==============================================================================
let g:plug_window = '-tabnew'
call plug#begin('~/.vim/plugged')

Plug 'thinca/vim-splash'

" Help
Plug 'vim-jp/vimdoc-ja'

" Colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'jacoborus/tender.vim'
Plug 'tomasr/molokai'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'

" Git / Gist
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'

" Edit
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'mattn/vim-sonictemplate'
Plug 'mechatroner/rainbow_csv'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-showtime'
Plug 'mattn/vim-goimports'
Plug 'tyru/open-browser.vim'
Plug 'Shougo/context_filetype.vim'

" Completion
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

" LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

" Language / Filetype
Plug 'ryanolsonx/vim-lsp-python', { 'for': 'python'}
Plug 'stephpy/vim-yaml',          { 'for': 'yaml'}
Plug 'cespare/vim-toml',          { 'for': 'toml'}
Plug 'b4b4r07/vim-ltsv',          { 'for': 'ltsv'}

" Docker
Plug 'honza/dockerfile.vim'

" Terraform
Plug 'hashivim/vim-terraform'

call plug#end()
" }}}

" ==============================================================================
" vim-plugin extension {{{
" ==============================================================================
" ------------------------------------------------------------------------------
" context_filetype
" ------------------------------------------------------------------------------
if !exists('g:context_filetype#filetypes')
  let g:context_filetype#filetypes = {}
endif
let g:context_filetype#filetypes.go = [
  \ {
  \   'filetype': 'sql',
  \   'start' : '  SELECT',
  \   'end' : '\s*\`'
  \ }
  \]
  "\   'start' : '(sql|SQL)\s*\:=\s*`', 'end' : '\s*`'}]

" ------------------------------------------------------------------------------
" open-browser
" ------------------------------------------------------------------------------
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap ob <Plug>(openbrowser-search)
vmap ob <Plug>(openbrowser-search)
let g:openbrowser_search_engines = {
		\       'go': 'http://pkg.go.dev/search?q={query}',
		\       'github': 'http://github.com/search?q={query}'
\}

" ------------------------------------------------------------------------------
" quickrun
" ------------------------------------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config.go = {'command' : 'go'}

" ------------------------------------------------------------------------------
" splash
" ------------------------------------------------------------------------------
let g:splash#path = $HOME . '/.vim/vim_intro.txt'

" ------------------------------------------------------------------------------
" vimdoc-ja
" ------------------------------------------------------------------------------
set helplang=en,ja

" ------------------------------------------------------------------------------
" lightline.vim
" ------------------------------------------------------------------------------
set t_Co=256
set laststatus=2

let g:lightline = {
  \'colorscheme': 'gruvbox',
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['gitbranch', 'readonly', 'filename', 'modified'],
  \  ],
  \  'right': [
  \    ['lineinfo'],
  \    ['fileformat', 'fileencoding', 'filetype']
  \  ]
  \},
  \'component_function': {
  \  'gitbranch': 'fugitive#head',
  \},
\}

" ------------------------------------------------------------------------------
" vim-easy-alignment
" ------------------------------------------------------------------------------
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------------------------
" vim-indent-guides
" ------------------------------------------------------------------------------
nmap <leader>i  <Plug>IndentGuidesToggle<CR>
let g:indent_guides_enable_on_vim_startup = 1 " vim起動時にindent-guide起動
let g:indent_guides_guide_size = 2            " indent-guideの単位
let g:indent_guides_color_change_percent = 5
let g:indent_guides_auto_colors = 0

" ------------------------------------------------------------------------------
" fzf
" ------------------------------------------------------------------------------
let g:fzf_layout = { 'down': '~40%'}
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \}

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -nargs=0 Ghq call fzf#run({
  \ 'source' : 'ghq list --full-path',
  \ 'sink' : 'cd'
  \})

command! -nargs=0 Mru call fzf#run({
  \ 'source' : v:oldfiles,
  \ 'sink' : 'edit',
  \ 'options' : '-m -x +s',
  \ 'down' : '40%'
  \})

command! -bang -nargs=? Memo
  \ call fzf#vim#files(expand($HOME . '/.config/memo/_posts'), fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap ,f  :Files<CR>
nmap ,s  :Snippet<CR>
nmap ,b  :Buffers<CR>
nmap ,g  :Ghq<CR>
nmap ,m  :Mru<CR>
nmap ,mm :Memo<CR>
nmap ,rg :Rg<CR>

" ------------------------------------------------------------------------------
" vim-lsp
" ------------------------------------------------------------------------------
" debug
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('./vim-lsp.log')

let g:lsp_async_completion = 1
let g:lsp_text_edit_enabled = 0

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_delay = 0
let g:lsp_diagnostics_echo_cursor = 1

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}

augroup VimLsp
  autocmd!
  autocmd Filetype go,python nmap <buffer> <leader>ac <plug>(lsp-code-action)
  autocmd Filetype go,python nmap <buffer> <leader>df <plug>(lsp-definition)
  autocmd Filetype go,python nmap <buffer> <leader>ho <plug>(lsp-hover)
augroup END

" if executable('pyls')
"   " pip install 'python-language-server[all]'
"   augroup pyls
"     autocmd!
"     autocmd User lsp_setup call lsp#register_server({
"           \ 'name': 'pyls',
"           \ 'cmd': {server_info->['pyls']},
"           \ 'whitelist': ['python'],
"           \})
"   augroup END
" endif

" if executable('gopls')
"   " go get golang.org/x/tools/gopls
"   augroup gopls
"     autocmd!
"     autocmd User lsp_setup call lsp#register_server({
"           \ 'name': 'gopls',
"           \ 'cmd': {server_info->['gopls']},
"           \ 'whitelist' : ['go'],
"           \ 'workspace_config': {
"           \   'gopls': {
"           \     'staticcheck': v:true,
"           \     'usePlaceholders': v:true
"           \     'completionDocumentation': v:false,
"           \     'watchFileChanges': v:true,
"           \     'hoverKind': 'SingleLine',
"           \   }},
"           \ })
"     autocmd FileType go setlocal omnifunc=lsp#complete
"     autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
"     autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
"   augroup END
" endif

autocmd FileType go setlocal omnifunc=lsp#complete
autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)

" if executable('solargraph')
"     " gem install solargraph
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'solargraph',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
"         \ 'initialization_options': {"diagnostics": "true"},
"         \ 'whitelist': ['ruby'],
"         \ })
" endif

" ------------------------------------------------------------------------------
" vim-lsp-settings
" ------------------------------------------------------------------------------
let g:lsp_settings_root_markers = [
  \ 'go.mod',
  \ '.git'
  \]

" ------------------------------------------------------------------------------
" vim-terraform
" ------------------------------------------------------------------------------
let g:terraform_fmt_on_save = 1
" }}}
" ==============================================================================
" basic {{{
" ==============================================================================
syntax enable
"set background=light
set background=dark
"let g:solarized_termcolors=256
let g:gruvbox_contrast_dark='hard'
"colorscheme tender
"colorscheme solarized
colorscheme gruvbox

" file
set encoding=utf-8           " vimでの文字エンコーディング
set termencoding=utf-8       " terminalでの文字エンコーディング
set fileencodings=utf-8,sjis " バッファの改行コード指定
set fileformats=unix,mac,dos " バッファの改行コード指定

" edit
set number
set clipboard+=unnamed     " clipboardとの連携
set noswapfile             " swapファイルを作成しない
set nobackup               " backupを作成しない
set viminfo=               " viminfoファイルを作成しない
set undodir=~/.vimundo
augroup undo
  autocmd BufReadPre ~/* setlocal undofile
augroup END
set nocursorcolumn         " カーソル位置(列)の非表示
set cursorline           " カーソル位置(行)の非表示
set nrformats=             " 10進数認識に変更
set virtualedit=block      " visual-block時、行末を超えて選択可能にする
set list                   " 不可視文字を表示
set listchars=tab:>-,trail:-,extends:>,precedes:<
set binary noeol           " ファイル末尾にeolを付けない
set foldmethod=marker
set write
"set scrolloff=999

" tab
set smarttab               " 行頭の余白内で<Tab>を入力すると、'shiftwidth'分をインデントする
set autoindent             " 自動インデント
set smartindent            " 自動インデント(ブロック対応)
set tabstop=2              " ファイル内の<Tab>が対応する空白の数
set softtabstop=2          " 編集で<Tab>の幅として使用する空白の数
set expandtab              " 挿入モードで<Tab>入力時、代わりに使う空白の数
set shiftwidth=2           " 自動インデントでのインデントの長さ

" search
set showmatch              " 対応する括弧をハイライトする
set hlsearch               " 検索結果をハイライト
set ignorecase             " 大文字/小文字の区別しない
set smartcase              " 大文字で検索されたら大文字/小文字を区別する

" json
set conceallevel=0         " ダブルクォーテーションを表示
"let g:vim_json_syntax_conceal = 0  " Yggrdroot/indentLineで2にしている設定を0に戻す
" }}}

" ==============================================================================
" key-mappings {{{
" ==============================================================================
nnoremap <leader>v :tabnew $MYVIMRC<CR>
nnoremap <leader>V :tabnew $MYGVIMRC<CR>
nnoremap <leader>s :source $MYVIMRC<CR>
nnoremap <leader>S :source $MYGVIMRC<CR>

noremap <silent><Esc><ESC> :<C-u>set nohlsearch!<CR>

nnoremap <leader><Tab>N :tabnew<CR>
nnoremap <leader><Tab>n :tabn<CR>
nnoremap <leader><Tab>p :tabp<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
" }}}

" ==============================================================================
" autocmd {{{
" ==============================================================================
augroup vimrc
  autocmd!
  " file types
  au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  au BufNewFile,BufRead *.tsv set filetype=tsv
  au BufNewFile,BufRead *.tf,*.tfvars,*.tfstate setlocal filetype=terraform
augroup END

" "TODOと同じハイライトに追加
augroup Highlight
  au!
  autocmd BufWinEnter * match Todo /\<DEBUG\>/
  autocmd BufWinEnter * match Todo /\<MEMO\>/
  autocmd BufWinEnter * match Todo /\<WIP\>/
  autocmd BufWinEnter * match Todo /\<DEV\>/
augroup END
" }}}
"
augroup MyAutoCmd
    if executable('pdftotext')
        " PDFファイルを開いた時、text形式に変換してから開く
        autocmd BufRead *.pdf :enew | 0read !pdftotext -layout -nopgbrk "#" -
    endif
    " 圧縮ファイルとPDFファイルを開いた時、readonlyモードで開き、j/kキーマップを変更
    autocmd BufRead *.zip,*.gz,*.bz2,*.xz,*.pdf setlocal readonly nolist
        \| nn <buffer> j <C-E> | nn <buffer> k <C-Y>
augroup END