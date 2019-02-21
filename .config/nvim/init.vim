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

" Color
Plug 'jacoborus/tender.vim'
Plug 'tomasr/molokai'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Status-line
Plug 'itchyny/lightline.vim'

" Browsing
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'

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
" lightline.vim
" ------------------------------------------------------------------------------
let g:lightline = {
  \'colorscheme': 'tender',
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['gitbranch', 'readonly', 'filename', 'modified'],
  \  ],
  \  'right': [
  \    ['fileformat', 'fileencoding', 'filetype']
  \  ]
  \},
  \'component_function': {
  \  'gitbranch': 'fugitive#head',
  \},
\}

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
  au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
  au BufNewFile,BufRead *.tf,*.tfvars,*.tfstate setlocal filetype=terraform
augroup END

" ------------------------------------------------------------------------------
" vim-terraform
" ------------------------------------------------------------------------------
let g:terraform_fmt_on_save = 1
" }}}

" ==============================================================================
" basic {{{
" ==============================================================================
set encoding=utf-8
set fileformat=unix
set noswapfile
set nobackup
set viminfo=
set noundofile
set clipboard+=unnamedplus
set number
set title
set cursorline
set ruler

set t_Co=256
set laststatus=2

" === tab ===
set autoindent    " 自動インデント
set smartindent   " 自動インデント(ブロック対応)
set expandtab     " tab入力でスペース挿入
set tabstop=2     " タブ幅
set softtabstop=2
set shiftwidth=2  " 自動インデントでのインデントの長さ

" === search ===
set showmatch
set hlsearch

syntax enable
colorscheme tender

" === json ===
" ダブルクォーテーションを表示
set conceallevel=0
let g:vim_json_syntax_conceal = 0
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
