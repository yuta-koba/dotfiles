" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ==============================================================================
" .vimrc of lunarxlark
" ==============================================================================
let mapleader = "\<Space>"

" ==============================================================================
" vim-plug {{{
" ==============================================================================
let g:plug_window = '-tabnew'
call plug#begin('~/.config/nvim/plugged')

" Help
Plug 'vim-jp/vimdoc-ja'

" Color
Plug 'jacoborus/tender.vim'
Plug 'tomasr/molokai'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Status-line
Plug 'itchyny/lightline.vim'

" Browsing
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'

" Edit 
Plug 'junegunn/vim-easy-align'
"Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'

" Language
Plug 'stephpy/vim-yaml', {'for': 'yaml'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}

" LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'natebosch/vim-lsc'

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
" vimdoc-ja
" ------------------------------------------------------------------------------
set helplang=ja,en

" ------------------------------------------------------------------------------
" lightline.vim
" ------------------------------------------------------------------------------
set t_Co=256
set laststatus=2

let g:lightline = {
  \'colorscheme': 'tender',
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
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------------------------
" vim-indent-guides
" ------------------------------------------------------------------------------
nmap <leader>ig  <Plug>IndentGuidesToggle<CR>
let g:indent_guides_enable_on_vim_startup = 1 " vim起動時にindent-guide起動
let g:indent_guides_auto_colors = 0           " colorschemeの色を使用しないように設定
let g:indent_guides_guide_size = 2            " indent-guideの単位

augroup IndentGuide
  autocmd!
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black    ctermbg=lightgray
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgray ctermbg=darkgray
augroup END


" ------------------------------------------------------------------------------
" asyncomplete
" ------------------------------------------------------------------------------
"let g:asyncomplete_smart_completion = 1
set completeopt+=preview


" ------------------------------------------------------------------------------
" vim-lsp
" ------------------------------------------------------------------------------
let g:lsp_diagnostics_echo_cursor = 1

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}

if executable('gopls')
  " go get -u golang.org/x/tools/cmd/gopls
  augroup LspGo
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
          \ 'whitelist' : ['go'],
          \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd BufWritePre <buffer> LspDocumentFormat
  augroup END
endif


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

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)


" ------------------------------------------------------------------------------
" asyncomplete
" ------------------------------------------------------------------------------
let g:asyncomplete_auto_popup = 1


" ------------------------------------------------------------------------------
" indentline
" ------------------------------------------------------------------------------
let g:indentLine_setColors = 0


" ------------------------------------------------------------------------------
" vim-go
" ------------------------------------------------------------------------------
augroup vimgo
  autocmd!
  " file types
  "au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  "au BufNewFile,BufRead *.tf,*.tfvars,*.tfstate setlocal filetype=terraform
augroup END


" ------------------------------------------------------------------------------
" vim-terraform
" ------------------------------------------------------------------------------
let g:terraform_fmt_on_save = 1


" }}}
" ==============================================================================
" basic {{{
" ==============================================================================
" color
syntax enable
colorscheme tender

" file
set encoding=utf-8         " vimでの文字エンコーディング
set fileformat=unix        " カレントバッファの改行コード指定

" edit
set clipboard+=unnamedplus " clipboardとの連携
set noswapfile             " swapファイルを作成しない
set nobackup               " backupを作成しない
set viminfo=               " viminfoファイルを作成しない
set noundofile             " undoファイルを作成しない
set nocursorcolumn         " カーソル位置(列)の非表示
set nocursorline           " カーソル位置(行)の非表示
set nrformats=             " 10進数認識に変更
set virtualedit=block      " visual-block時、行末を超えて選択可能にする

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
nnoremap <leader>v :edit $MYVIMRC<CR>
nnoremap <leader>s :source $MYVIMRC<CR>

inoremap <silent> jj <ESC>

noremap <silent><Esc><ESC> :<C-u>set nohlsearch!<CR>

noremap <leader>lac :LspCodeAction<CR>
noremap <leader>ldec :LspDeclaration<CR>
noremap <leader>ldef :LspDefinition<CR>
" }}}

" ==============================================================================
" autocmd {{{
" ==============================================================================
augroup vimrc
  autocmd!
  " file types
  au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  au BufNewFile,BufRead *.tf,*.tfvars,*.tfstate setlocal filetype=terraform
augroup END

" "DEBUG"をTODOと同じハイライトに追加
augroup DebugHighlight
  au!
  autocmd BufWinEnter * match Todo /\<DEBUG\>/
augroup END
" }}}
