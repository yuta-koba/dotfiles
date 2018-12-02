let mapleader = "\<Space>"

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

"let s:dein_config = '~/.config/nvim/toml'
let s:dein_config = $XDG_CONFIG_HOME . '/nvim/toml'
"let s:dein_cache = '~/.cache/dein'
let s:dein_cache = $XDG_CACHE_HOME . '/dein'
let s:dein_repo = s:dein_cache . '/repos/github.com/Shougo/dein.vim'

" Required:
set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim
"set runtimepath+=$XDG_CONFIG_HOME/fzf

"let g:python_host_prog = '/usr/bin/python'
"let g:python3_host_prog = "/Users/lunarxlark/Documents/anyenv/envs/pyenv/shims/python3"
"let g:ruby_host_prog = "/Users/lunarxlark/Documents/anyenv/envs/rbenv/shims/ruby"


" Required:
if dein#load_state( s:dein_cache )
  call dein#begin( s:dein_cache )
  call dein#add( s:dein_repo )

  let g:rc_dir = expand( s:dein_config )

  let s:toml_init   = g:rc_dir . '/dein_init.toml'
  let s:toml_lazy   = g:rc_dir . '/dein_lazy.toml'
  "let s:toml_toml   = g:rc_dir . '/dein_toml.toml'
  "let s:toml_yaml   = g:rc_dir . '/dein_yaml.toml'
  "let s:toml_python = g:rc_dir . '/dein_python.toml'
  "let s:toml_aws    = g:rc_dir . '/dein_aws.toml'
  "let s:toml_hashi  = g:rc_dir . '/dein_hashi.toml'
  "let s:toml_docker = g:rc_dir . '/dein_docker.toml'
  "let s:toml_go     = g:rc_dir . '/dein_go.toml'

  cal dein#load_toml(s:toml_init,   {'lazy': 0})
  cal dein#load_toml(s:toml_lazy,   {'lazy': 1})
  "cal dein#load_toml(s:toml_toml,   {'lazy': 1})
  "cal dein#load_toml(s:toml_yaml,   {'lazy': 1})
  "cal dein#load_toml(s:toml_python, {'lazy': 1})
  "cal dein#load_toml(s:toml_aws,    {'lazy': 1})
  "cal dein#load_toml(s:toml_hashi,  {'lazy': 1})
  "cal dein#load_toml(s:toml_docker, {'lazy': 1})
  "cal dein#load_toml(s:toml_go,     {'lazy': 1})


  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
"End dein Scripts-------------------------

" === basic ===
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

colorscheme tender


" key map
noremap <C-n> :tabnew<CR>
noremap <S-Tab> :tabnext<CR>
noremap <leader>tt :terminal<CR>

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
noremap <silent><Esc><ESC> :<C-u>set nohlsearch!<CR>

" === json ===
" ダブルクォーテーションを表示
set conceallevel=0
let g:vim_json_syntax_conceal = 0


"" === terraform-completion-vim ===
"let g:deoplete#omni_patterns = {}
"
"call deoplete#custom#option('omni_patterns', {
"  \ 'complete_method': 'omnifunc',
"  \ 'terraform': '[^ *\t"{=$]\w*',
"  \})
"call deoplete#initialize()
