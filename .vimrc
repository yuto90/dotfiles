"dein Scripts----------------------------- 
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_path = expand('~/.cache/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)


  let g:config_dir  = expand('~/.cache/userconfig')
  let s:toml        = g:config_dir . '/plugin.toml'
  let s:lazy_toml   = g:config_dir . '/plugin_lazy.toml'

  " TOML 読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif


" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------
"
" バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
 set noswapfile"

" バッファが編集中でもその他のファイルを開けるように
set hidden
" 保存したら自動更新
autocmd BufWritePost  ~/.vimrc  so ~/.vimrc

" ターミナル機能
" autocmd VimEnter * execute 'bo term ++rows=10'

"インデント可視化
set list
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" エンコーディング
set encoding=utf-8
scriptencoding utf-8

" 自動でNERDTree起動
"autocmd VimEnter * execute 'NERDTree'
"
set expandtab
" タブ文字の表示幅
set tabstop=4
" Vimが挿入するインデントの幅
set shiftwidth=4
"
" leader設定
let mapleader = "\<space>"

"jキーを二度押しでESCキー
inoremap <silent> jj <Esc>
inoremap <silent> っj <ESC>

"help日本語化
set helplang=ja
"行番号を表示
set number 
" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start
"検索系
set hlsearch
set ignorecase
set incsearch
set smartcase
set laststatus=2

set showcmd
set visualbell

syntax on "シンタックスハイライト
"colorscheme monokai
colorscheme molokai "カラースキーム
hi Comment ctermfg=102
hi Visual  ctermbg=39

" 自動で閉じる
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

"棒状カーソル"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
inoremap <Esc> <Esc>lh

" ヤンクがクリップボードに保存
set clipboard+=unnamed

" flutter関係
if expand("%:t") =~ ".*\.dart"
    nnoremap <leader>fa :FlutterRun<cr>
    nnoremap <leader>fq :FlutterQuit<cr>
    nnoremap <leader>hr :FlutterHotReload<cr>
    nnoremap <leader>fR :FlutterHotRestart<cr>
endif

" セーブ時にhotreload
function! TriggerFlutterHotReload() abort
  silent execute '!kill -SIGUSR1 $(pgrep -f "[f]lutter_tool.*run")'
 endfunction
 autocmd! BufWritePost *.dart call TriggerFlutterHotReload()

"""""""""""""""""""""""""
"      インデント
""""""""""""""""""""""""
set autoindent          "改行時に前の行のインデントを計測
set smartindent         "改行時に入力された行の末尾に合わせて次の行のインデントを増減する 
set cindent             "Cプログラムファイルの自動インデントを始める
set smarttab            "新しい行を作った時に高度な自動インデントを行う
set expandtab           "タブ入力を複数の空白に置き換える 

set tabstop=2           "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
set shiftwidth=2        "自動インデントで入る空白数
set softtabstop=0       "キーボードから入るタブの数

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
  autocmd FileType dart        setlocal sw=2 sts=2 ts=2 et
endif



" ===================プラグイン系====================
"
" vim-airline---------------------------------------------------------
let g:airline_theme = 'angr'
set ttimeoutlen=50
let g:airline#extensions#tabline#enabled = 1
nmap <C-m> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
	\ '0': '0 ',
	\ '1': '1 ',
	\ '2': '2 ',
	\ '3': '3 ',
	\ '4': '4 ',
	\ '5': '5 ',
	\ '6': '6 ',
	\ '7': '7 ',
	\ '8': '8 ',
	\ '9': '9 '
	\}

" guifontを設定しないと文字化けになる。terminalで行ったフォントの設定と同様
" 公式サイトではLinuxとmacOSの設定が若干異なるが、Linuxの設定でもmacOSで問題なし
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
  set encoding=utf-8

  " フォルダアイコンを表示
  let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
  let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
  " after a re-source, fix syntax matching issues (concealing brackets):
  if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
  endif
"--------------------------------------------------------------------
