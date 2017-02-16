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
" タブ幅2
set tabstop=2
set shiftwidth=2
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

"-------------------------------------------------------------------------------
" カレントウィンドウにのみ罫線を引く
"-------------------------------------------------------------------------------
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

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
" C
autocmd Filetype c setlocal cindent
autocmd Filetype h setlocal cindent
" C++
autocmd Filetype cpp setlocal cindent
autocmd Filetype hpp setlocal cindent
" Python
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" Java
autocmd Filetype java setlocal cindent
" Makefile
autocmd Filetype make setlocal noexpandtab

"-------------------------------------------------------------------------------
" ファイル名前によってファイルタイプを設定
"-------------------------------------------------------------------------------
" .vimperatorrc,_vimpeartorrc
autocmd BufNewFile,BufRead .vimperatorrc setlocal filetype=vim
autocmd BufNewFile,BufRead _vimperatorrc setlocal filetype=vim

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

"-------------------------------------------------------------------------------
" neovundle設定
"-------------------------------------------------------------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
\   'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\}
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'honza/vim-snippets'
NeoBundle 'rkitover/vimpager', {
\   'build' : {
\     'windows' : 'chmod +x vimpager',
\     'cygwin' : 'chmod +x vimpager',
\     'mac' : 'chmod +x vimpager',
\     'unix' : 'chmod +x vimpager',
\   },
\}
NeoBundle 'thinca/vim-template'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'sudo.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'itchyny/lightline.vim'
"NeoBundle "davidhalter/jedi-vim", {
"      \ "autoload": {
"      \   "filetypes": ["python"]
"      \ }}

call neobundle#end()
NeoBundleCheck

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインの設定
"-------------------------------------------------------------------------------
" neocomplcache
let g:neocomplcache_enable_at_startup = 1
" neosnippet
imap <expr><TAB>
\ neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" vimdoc-ja
set helplang=ja,en
" nerdtree
let g:NERDTreeShowHidden = 1
" ref.vim
let g:ref_source_webdict_sites = {}
let g:ref_source_webdict_sites.default = 'ej'
let g:ref_source_webdict_sites.en = {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   }
let g:ref_source_webdict_sites.en2 = {
\     'url': 'http://ejje.weblio.jp/content/%s',
\   }
let g:ref_source_webdict_sites.wiki = {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   }
function! g:ref_source_webdict_sites.en.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.en2.filter(output)
  return join(split(a:output, "\n")[57 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction
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
    \                'rm -rf %s:r.dvi %s:r.log %s:r.aux %s:r.toc',
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
    \                'rm -rf %s:r.dvi %s:r.log %s:r.aux %s:r.toc',
    \                'open -g %s:r.pdf || true'],
    \   }
  endif
endif
"unite.vim
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 200
" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" jedi-vim
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインにショートカットを設定
"-------------------------------------------------------------------------------
"nothing

"-------------------------------------------------------------------------------
" テンプレート
"-------------------------------------------------------------------------------
" テンプレート中に含まれる特定文字列を置き換える
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
  silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
  silent! %s/<+FILENAME+>/\=expand('%:r')/g
  silent! %s/<+CFILENAME+>/\=toupper(expand('%:r'))/g
endfunction
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd User plugin-template-loaded
  \   if search('<+CURSOR+>')
  \ |   silent! execute 'normal! "_da>'
  \ | endif

"-------------------------------------------------------------------------------
" Load other vimrc
"-------------------------------------------------------------------------------
source $HOME/.vimrc_env

"-------------------------------------------------------------------------------
" Autostart
"-------------------------------------------------------------------------------
"autocmd VimEnter * NERDTree
syntax on
