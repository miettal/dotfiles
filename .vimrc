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
" 大文字小文字関係なく検索
set ignorecase
" zsh風の補完候補表示
set wildmode=list:longest
" 入力中のコマンド表示
set showcmd
" タブをスペースで埋める
set expandtab
" カレント行に下線を引く
set cursorline
" カラースキームを設定
colorscheme desert
" シンタックスハイライトオン
syntax on

"-------------------------------------------------------------------------------
" カレントウィンドウにのみ罫線を引く
"-------------------------------------------------------------------------------
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline

"-------------------------------------------------------------------------------
" ショートカットを設定
"-------------------------------------------------------------------------------
" Escの2回押しでハイライト消去
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-h> :<C-u>help<Space><C-r><C-w><CR>
" ペイン移動を楽にする
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"-------------------------------------------------------------------------------
" ファイルの種別によってコマンドを実行
"-------------------------------------------------------------------------------
" Cのファイルはcindentにする
autocmd Filetype c setl cindent
autocmd Filetype cuda setl cindent
autocmd Filetype cpp setl cindent
" pythonのファイルはautoindentとsmartindentにする
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"-------------------------------------------------------------------------------
" ファイル名前によってファイルタイプを設定
"-------------------------------------------------------------------------------
" .vimperatorrc,_vimpeartorrcはvimrcとして扱う
autocmd BufNewFile,BufRead .vimperatorrc setl filetype=vim
autocmd BufNewFile,BufRead _vimperatorrc setl filetype=vim

"-------------------------------------------------------------------------------
" テンプレート
"-------------------------------------------------------------------------------
" Cのヘッダファイル
autocmd BufNewFile *.h call IncludeGuard()
function! IncludeGuard()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename . "_INCLUDED"
  execute "normal! o#define " . gatename .  "_INCLUDED\<CR>\<CR>\<CR>\<CR>\<CR>"
  execute "normal! Go#endif   /* " . gatename . "_INCLUDED */"
  4
endfunction 

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
" brainfuck.vim設定
"-------------------------------------------------------------------------------
set runtimepath+=~/.vim/brainfuck
nnoremap <C-i><C-f> :<C-u>call<Space>Bfrun_current_buffer()<CR>

"-------------------------------------------------------------------------------
" Vundle設定
"-------------------------------------------------------------------------------
set runtimepath+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'neocomplcache'
Bundle 'quickrun'
Bundle 'Arduino-syntax-file'
Bundle 'HTML5-Syntax-File'
Bundle 'unite.vim'
Bundle 'TwitVim'
Bundle 'Gist.vim'
Bundle 'thinca/vim-ref'
Bundle 'sudo.vim'
Bundle 'vimpager'
Bundle 'TeTrIs.vim'
Bundle 'ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'motemen/hatena-vim'
Bundle 'vim-jp/vimdoc-ja'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Shougo/neosnippet'
Bundle 'majutsushi/tagbar'
Bundle 'sjl/gundo.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインの設定
"-------------------------------------------------------------------------------
" neocomplcache
let g:neocomplcache_enable_at_startup = 1
" arduino-syntax
autocmd BufNewFile,BufRead *.pde setlocal filetype=arduino
" powerline
let g:Powerline_symbols = 'compatible'
" neosnippet
imap <expr><TAB>
\ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"
" vimdoc-ja
set helplang=ja,en
" ref.vim
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\ }
let g:ref_source_webdict_sites.default = 'ej'
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction
" quickrun
let g:quickrun_config = {
\   "make" : {
\       "command"   : "mingw32-make",
\       "exec" : "%c %o",
\       "outputter" : "error:buffer:quickfix",
\       "runner" : "vimproc",
\   },
\}

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインにショートカットを設定
"-------------------------------------------------------------------------------
" twitvim
nnoremap <C-i><C-t> :<C-u>CPosttoTwitter<CR>
nnoremap <C-i><C-f> :<C-u>Unite buffer file file_mru<CR>
nnoremap <C-i><C-i> :<C-u>TagbarToggle<CR>
" ref.vim
nnoremap <Leader>je :<C-u>Ref webdict je<Space>
nnoremap <Leader>ej :<C-u>Ref webdict ej<Space>
nnoremap <Leader>wiki :<C-u>Ref webdict wiki<Space>

"-------------------------------------------------------------------------------
" やる気を出す
"-------------------------------------------------------------------------------
autocmd VimEnter * echo "千里の道も一歩から．ガツガツコードを書こう！"
