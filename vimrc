"-------------------------------------------------------------------------------
" 基本設定
"-------------------------------------------------------------------------------
" 判別不能のファイルをUTF-8で開く
set encoding=utf-8
" 判別の順番と読み込む文字コード
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" 行番号表示
set number
" インクリメンタル検索する
set incsearch
" 検索結果をハイライトする
set hlsearch
" vi互換モードを切る
set nocompatible
" タブ幅4
set tabstop=4
set shiftwidth=4
set softtabstop=0
" バックスペース設定
set backspace=indent,eol,start
" ステータスライン常に表示
set laststatus=2
" 大文字小文字関係なく探索
set ignorecase
" 大文字で探索の場合，大文字小文字区別
set smartcase
" バッファを閉じる代わりに隠す（Undo履歴を残すため）
set hidden
" 不可視文字の可視化
set list
" zsh風の補完候補表示
set wildmode=list:longest
" 入力中のコマンド表示
set showcmd
" タブをスペースで埋める
set expandtab
" *.texはlatexファイルタイプで開く
let g:tex_flavor = "latex"
" 全角幅の記号正しく表示する
set ambiwidth=double
colorscheme koehler
set shortmess+=I
" 80文字目に赤いラインを入れる
set colorcolumn=80

"-------------------------------------------------------------------------------
" ショートカットを設定
"-------------------------------------------------------------------------------
" ペイン移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"-------------------------------------------------------------------------------
" ファイルの種別によってコマンドを実行
"-------------------------------------------------------------------------------
autocmd Filetype c setlocal cindent
autocmd Filetype h setlocal cindent
" C++
autocmd Filetype cpp setlocal cindent
autocmd Filetype hpp setlocal cindent
" Python
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" Ruby
autocmd FileType ruby setlocal autoindent
autocmd FileType ruby setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
" Javascript
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
" Java
autocmd Filetype java setlocal cindent
" Makefile
autocmd Filetype make setlocal noexpandtab

"-------------------------------------------------------------------------------
" ファイル名前によってファイルタイプを設定
"-------------------------------------------------------------------------------
"
"-------------------------------------------------------------------------------
" バイナリエディタ設定
"-------------------------------------------------------------------------------
" バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin ファイルを開くと発動）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

"-------------------------------------------------------------------------------
" 環境変数
"-------------------------------------------------------------------------------
let PATH = expand("~/.pyenv/shims") . ":" . $PATH
let PATH = expand("~/.rbenv/shims") . ":" . $PATH

"-------------------------------------------------------------------------------
" dein.vim設定
"-------------------------------------------------------------------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein')
  call dein#begin('~/.vim/dein')


  call dein#add('Shougo/deoplete.nvim')
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')

  call dein#add('thinca/vim-quickrun')
  call dein#add('Shougo/vimproc', {'build': 'make'})

  call dein#add('itchyny/lightline.vim')

  call dein#add('dense-analysis/ale')

  call dein#add('airblade/vim-gitgutter')

  call dein#add('nathanaelkane/vim-indent-guides')

  call dein#add('othree/yajs.vim')
  call dein#add('maxmellon/vim-jsx-pretty')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインの設定
"-------------------------------------------------------------------------------
" ale
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'python': ['autopep8', 'isort'],
\ }
let g:ale_linter_aliases = {
\   'htmldjango': ['html'],
\}
" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 200)
" vim-gitgutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_highlight_lines = 1
" quickrun
let g:quickrun_config = {}
let g:quickrun_config._ = {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   }
let g:quickrun_config.make = {
\       "outputter" : "error:buffer:quickfix",
\       "command"   : "make",
\       "exec" : "%c %o",
\   }
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Linux\n"
    let g:quickrun_config.tex = {
    \       "outputter" : "error:error:buffer",
    \       'command'   : 'platex',
    \       'exec': [
    \                '%c %s',
    \                '%c %s',
    \                'dvipdfmx -o %s:r.pdf %s:r.dvi',
    \                'rm %s:r.dvi %s:r.log %s:r.aux %s:r.toc',
    \                'gnome-open %s:r.pdf &'],
    \   }
  elseif s:uname == "Darwin\n"
    let g:quickrun_config.tex = {
    \       "outputter" : "error:error:buffer",
    \       'command'   : 'platex',
    \       'exec': [
    \                '%c %s',
    \                '%c %s',
    \                'dvipdfmx -o %s:r.pdf %s:r.dvi',
    \                'rm %s:r.dvi %s:r.log %s:r.aux %s:r.toc',
    \                'open -g %s:r.pdf'],
    \   }
  endif
endif

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインにショートカットを設定
"-------------------------------------------------------------------------------
"nothing

"-------------------------------------------------------------------------------
" Load other vimrc
"-------------------------------------------------------------------------------
source $HOME/.vimrc_env

syntax enable
