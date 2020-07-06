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
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
let g:ruby_host_prog = $RBENV_ROOT . '/shims/ruby'

" ==============================================================================
" vim-plug {{{
" ==============================================================================
let g:plug_window = '-tabnew'
call plug#begin('~/.config/nvim/plugged')

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
"Plug 'liuchengxu/vista.vim'
Plug 'mattn/vim-sonictemplate'
Plug 'mechatroner/rainbow_csv'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-showtime'
Plug 'mattn/vim-goimports'
Plug 'delphinus/vim-denite-memo'
Plug 'tyru/open-browser.vim'

" Dark power
Plug 'Shougo/denite.nvim', {'do': 'UpdateRemotePlugins'}
Plug 'Shougo/neomru.vim'
Plug 'Jagua/vim-denite-ghq'
"Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

" Completion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
"Plug 'natebosch/vim-lsc'
"Plug 'autozimu/LanguageClient-neovim', {
"      \ 'branch': 'next',
"      \ 'do': 'bash install.sh',
"      \}

" Language / Filetype
"Plug 'fatih/vim-go',              { 'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'mattn/vim-goimports'
Plug 'ryanolsonx/vim-lsp-python', { 'for': 'python'}
Plug 'stephpy/vim-yaml',          { 'for': 'yaml'}
Plug 'cespare/vim-toml',          { 'for': 'toml'}
Plug 'b4b4r07/vim-ltsv',          { 'for': 'ltsv'}

" Docker
Plug 'honza/dockerfile.vim'

" Terraform
Plug 'hashivim/vim-terraform'

" Now testing
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"if !has('nvim')
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"Plug 'Shougo/deol.nvim'
"Plug 'zchee/deoplete-zsh'

call plug#end()
" }}}

" ==============================================================================
" vim-plugin extension {{{
" ==============================================================================
" ------------------------------------------------------------------------------
" open-browser
" ------------------------------------------------------------------------------
let g:netrw_nogx = 1 " disable netrw's gx mapping.
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
" denite
" ------------------------------------------------------------------------------
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

" grep
call denite#custom#var('grep', 'command', ['pt'])
call denite#custom#var('grep', 'default_opts', ['-i', '--smart-case'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

noremap ,db :Denite buffer<CR>
"noremap ,df :Denite file/rec -split=tab -auto-preview -vertical-preview<CR>
noremap ,df :Denite file/rec -split=tab<CR>
"noremap ,dmf :Denite file_mru -split=tab -auto-preview -vertical-preview<CR>
noremap ,dmf :Denite file_mru -split=tab<CR>
noremap ,dd :Denite directory_rec -winheight=10<CR>
noremap ,dmd :Denite directory_mru -winheight=10<CR>
noremap ,dgh :Denite ghq -winheight=10<CR>
noremap ,dg :DeniteProjectDir grep  -split=tab -buffer-name=dgb<CR>
noremap ,dG :DeniteProjectDir grep -auto-resume -buffer-name=dgb<CR>
noremap ,dgr :DeniteProjectDir -resume -buffer-name=dgb<CR>
noremap ,dgn :DeniteProjectDir -resume -buffer-name=dgb -select=+1 -immediately<CR>
noremap ,dn :DeniteProjectDir -buffer-name=dgb -select=+1 -immediately<CR>
noremap ,dgp :DeniteProjectDir -resume -buffer-name=dgb -select=-1 -immediately<CR>
noremap ,dp :DeniteProjectDir -buffer-name=dgb -select=-1 -immediately<CR>

" change mapping
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', "<C-v>", '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', "<C-h>", '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', "jj", '<denite:enter_mode:normal>')


let g:gruvbox_contrast_dark = 'hard'
" ------------------------------------------------------------------------------
" splash
" ------------------------------------------------------------------------------
let g:splash#path = $HOME . '/.config/nvim/nvim_intro.txt'

" ------------------------------------------------------------------------------
" splash
" ------------------------------------------------------------------------------
let g:splash#path = $HOME . '/.config/nvim/nvim_intro.txt'

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
nmap <leader>ig  <Plug>IndentGuidesToggle<CR>
let g:indent_guides_enable_on_vim_startup = 1 " vim起動時にindent-guide起動
let g:indent_guides_guide_size = 2            " indent-guideの単位
let g:indent_guides_color_change_percent = 5
let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=205
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=205

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

command! -nargs=0 Ghqlist call fzf#run({
      \ 'source' : 'ghq list --full-path',
      \ 'sink' : 'cd'
      \})

command! -nargs=0 Mru call fzf#run({
      \ 'source' : v:oldfiles,
      \ 'sink' : 'edit',
      \ 'options' : '-m -x +s',
      \ 'down' : '41%'
      \})

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <leader>ff :Files<CR>
nmap <leader>fs :Snippet<CR>
nmap <leader>fb :Buffers<CR>
"nmap <leader>fg :Ghqlist<CR>
nmap <leader>fm :Mru<CR>

" ------------------------------------------------------------------------------
" tagbar
" ------------------------------------------------------------------------------
nmap <leader>t :TagbarToggle<CR>

"  go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_terraform = {
    \ 'ctagstype' : 'terraform',
    \ 'kinds' : [
    \   'r:resources',
    \   'm:modules',
    \   'o:outputs',
    \   'v:variables',
    \   'f:tfvars'
    \ ],
    \ 'sort' : 0
    \ }

" ------------------------------------------------------------------------------
" asyncomplete
" ------------------------------------------------------------------------------
" debug
"let g:asyncomplete_log_file = expand('./asyncomplete.log')

"set completeopt+=preview
"let g:asyncomplete_smart_completion = 1
"let g:asyncomplete_auto_popup = 1
"augroup Asyncomplete
"  autocmd!
"    imap <c-space> <Plug>(asyncomplete_force_refresh)
"    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"    inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
"    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"augroup END

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

if executable('pyls')
  " pip install 'python-language-server[all]'
  augroup pyls
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \})
  augroup END
endif

if executable('gopls')
  " go get golang.org/x/tools/gopls
  augroup gopls
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls']},
          \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'go.mod'))},
          \ 'whitelist' : ['go'],
          \ 'workspace_config': {'gopls': {
          \     'staticcheck': v:true,
          \     'completeUnimported': v:true,
          \     'caseSensitiveCompletion': v:true,
          \     'usePlaceholders': v:true,
          \     'completionDocumentation': v:true,
          \     'watchFileChanges': v:true,
          \     'hoverKind': 'SingleLine',
          \ }},
          \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
    autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
  augroup END
endif

if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

" ------------------------------------------------------------------------------
" LanguageClient-neovim
" ------------------------------------------------------------------------------
"let g:LanguageClient_rootMarkers = {
"        \ 'go': ['.git', 'go.mod'],
"        \ }
"
"let g:LanguageClient_serverCommands = {
"    \ 'python': ['/usr/local/bin/pyls'],
"    \ 'go': ['gopls'],
"    \ }
"
"autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
"
"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"nnoremap <leader>ho :call LanguageClient#textDocument_hover()<CR>
"nnoremap <leader>df :call LanguageClient#textDocument_definition()<CR>
"nnoremap <leader>rn :call LanguageClient#textDocument_rename()<CR>
"
"let g:LanguageClient_loggingLevel = 'DEBUG'
"let g:LanguageClient_loggingFile =  expand('~/.config/nvim/LanguageClient.log')
"let g:LanguageClient_serverStderr = expand('~/.config/nvim/LanguageServer.log')

" ------------------------------------------------------------------------------
" vim-go
" ------------------------------------------------------------------------------
"let $PATH = $HOME . "/.local/go/bin:" . $PATH
"let $GOPATH = $HOME . "/dev"
"let g:go_bin_path = $HOME . "/.local/go/bin/go"
"
"augroup vimgo
"  autocmd!
"  let g:go_highlight_types = 1
"  let g:go_highlight_fields = 1
"  let g:go_highlight_functions = 1
"  let g:go_highlight_function_calls = 1
"  let g:go_highlight_operators = 1
"  let g:go_highlight_extra_types = 1
"  let g:go_highlight_generate_tags = 1
"  let g:go_highlight_variable_declarations = 1
"
"  let g:go_term_mode = "split"
"  let g:go_term_height = 10
"
"  let g:go_info_mode = "gopls"
"  let g:go_def_mode = "gopls"
"  let g:go_fmt_command = "goimports"
"  let g:go_snippet_engine = "ultisnips"
"  let g:go_list_type = "quickfix"
"
"  autocmd FileType go nmap <leader>gb  <Plug>(go-build)
"  autocmd FileType go nmap <leader>gr  <Plug>(go-run)
"  autocmd FileType go nmap <leader>dc  :GoDoc<CR>
"  autocmd FileType go nmap <leader>dcb :GoDocBrowser<CR>
"  autocmd FileType go nmap <leader>gif :GoIfErr<CR>
"  autocmd FileType go nmap <leader>gR  :GoRun %<CR>
"  autocmd FileType go nmap <leader>gt  <Plug>(go-test)
"
"  au BufNewFile,BufRead,BufReadPost *.godoc set syntax=go
"augroup END


" ------------------------------------------------------------------------------
" UltiSnips
" ------------------------------------------------------------------------------
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetDirectories = [ 'UltiSnips', $HOME.'/.config/UltiSnips/aws']
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
"call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
"    \ 'name': 'ultisnips',
"    \ 'whitelist': ['*'],
"    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
"    \ }))

" ------------------------------------------------------------------------------
" deoplete {{{
" ------------------------------------------------------------------------------
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_ignore_case = 1
"let g:deoplete#source#yaml = ['buffer', 'file', 'ultisnips']
"call deoplete#custom#option({
"      \ 'auto_complete_delay': 0,
"      \ 'auto_refresh_delay': 0,
"      \ 'min_pattern_length': 1,
"      \})
"
""call deoplete#custom#option('sources', {
""      \ 'python3': ['LanguageClient'],
""      \ 'go': ['LanguageClient'],
""      \})
"
"call deoplete#custom#source(
"      \ 'LanguageClient',
"      \ 'min_pattern_length',
"      \ 1)
"
"autocmd BufEnter * call ncm2#enable_for_buffer()
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"set completeopt=noinsert,menuone,noselect

" ------------------------------------------------------------------------------
" vim-terraform
" ------------------------------------------------------------------------------
let g:terraform_fmt_on_save = 1
" }}}

" ==============================================================================
" basic {{{
" ==============================================================================
" color
"
syntax enable
"let g:solarized_termcolors=256
let g:gruvbox_contrast_dark='hard'
"colorscheme tender
"colorscheme solarized
colorscheme gruvbox
"set background=light
set background=dark

" file
set encoding=utf-8           " vimでの文字エンコーディング
"set termencoding=utf-8       " terminalでの文字エンコーディング
set fileencodings=sjis,utf-8 " バッファの改行コード指定
set fileformats=unix,dos,mac " バッファの改行コード指定

" edit
set number
set clipboard+=unnamedplus " clipboardとの連携
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
nnoremap <leader>g :tabnew ~/.gonvim/setting.toml<CR>
nnoremap <leader>V :tabnew $MYGVIMRC<CR>
nnoremap <leader>s :source $MYVIMRC<CR>
nnoremap <leader>S :source $MYGVIMRC<CR>

noremap <silent><Esc><ESC> :<C-u>set nohlsearch!<CR>

inoremap <silent> jj <ESC>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

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
  au BufNewFile,BufRead *.showtime |\ <Plug>IndentGuidesToggle<CR>
augroup END

autocmd QuickFixCmdPost *grep* cwindow

" "TODOと同じハイライトに追加
augroup Highlight
  au!
  autocmd BufWinEnter * match Todo /\<DEBUG\>/
  autocmd BufWinEnter * match Todo /\<MEMO\>/
  autocmd BufWinEnter * match Todo /\<WIP\>/
  autocmd BufWinEnter * match Todo /\<DEV\>/
augroup END
" }}}