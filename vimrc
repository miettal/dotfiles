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
" カレント行に下線を引く
"set cursorline
"autocmd VimEnter,ColorScheme * highlight CursorLine term=reverse cterm=reverse
" *.texはlatexファイルタイプで開く
let g:tex_flavor = "latex"
" 全角幅の記号正しく表示する
set ambiwidth=double
" ステータスラインにフィアル名，文字コード，改行コードを表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"-------------------------------------------------------------------------------
" カレントウィンドウにのみ罫線を引く
"-------------------------------------------------------------------------------
"autocmd WinLeave * set nocursorline
"autocmd WinEnter,BufRead * set cursorline

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
autocmd Filetype c setlocal cindent
autocmd Filetype cuda setlocal cindent
autocmd Filetype cpp setlocal cindent
" pythonのファイルはautoindentとsmartindentにする
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" Javaのファイルはcindentにする
autocmd Filetype java setlocal cindent
" Makefileではスペースをタブ代わりに使わない
autocmd Filetype make setlocal noexpandtab

"-------------------------------------------------------------------------------
" ファイル名前によってファイルタイプを設定
"-------------------------------------------------------------------------------
" .vimperatorrc,_vimpeartorrc
autocmd BufNewFile,BufRead .vimperatorrc setlocal filetype=vim
autocmd BufNewFile,BufRead _vimperatorrc setlocal filetype=vim
" Arduino
autocmd BufNewFile,BufRead *.ino setlocal cindent
autocmd BufNewFile,BufRead *.pde setlocal cindent
" Markdown
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

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
" TODO設定
"-------------------------------------------------------------------------------
" TODOを\-tで一覧表示
noremap <Leader>t :noautocmd vimgrep /TODO/j * <CR>:cw<CR>

"-------------------------------------------------------------------------------
" brainfuck.vim設定
"-------------------------------------------------------------------------------
set runtimepath+=~/.vim/brainfuck
nnoremap <C-i><C-f> :<C-u>call<Space>Bfrun_current_buffer()<CR>

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
NeoBundle 'Arduino-syntax-file'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'HTML5-Syntax-File'
NeoBundle 'TwitVim'
NeoBundle 'Gist.vim'
NeoBundle 'sudo.vim'
NeoBundle 'vimpager', {
\   'build' : {
\     'windows' : 'chmod +x vimpager',
\     'cygwin' : 'chmod +x vimpager',
\     'mac' : 'chmod +x vimpager',
\     'unix' : 'chmod +x vimpager',
\   },
\}
NeoBundle 'basyura/twibill.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'basyura/TweetVim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kevinw/pyflakes-vim'
NeoBundle 'osyo-manga/vim-gyazo'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'moznion/hateblo.vim'
"NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'supermomonga/shaberu.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-template'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'airblade/vim-gitgutter'
call neobundle#end()
NeoBundleCheck

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインの設定
"-------------------------------------------------------------------------------
" neocomplcache
let g:neocomplcache_enable_at_startup = 1
" arduino-syntax
autocmd BufNewFile,BufRead *.ino setlocal filetype=arduino
autocmd BufNewFile,BufRead *.pde setlocal filetype=arduino
autocmd BufNewFile,BufRead *.ino let b:quickrun_config={'exec': ['ino build && ino upload && ino serial']}
autocmd BufNewFile,BufRead *.pde let b:quickrun_config={'exec': ['ino build && ino upload && ino serial']}
" powerline
let g:Powerline_symbols = 'compatible'
" neosnippet
imap <expr><TAB>
\ neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" vimdoc-ja
set helplang=ja,en
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
" hateblo.vim
let g:hateblo_vim = {
     \ 'user':         'miettal',
     \ 'api_key':      'hkoxbik8qe',
     \ 'api_endpoint': 'https://blog.hatena.ne.jp/miettal/miettal.hatenablog.com/atom',
     \ 'edit_command': 'edit'
\ }
"unite.vim
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
"syaberu.vim
let g:shaberu_user_define_say_command = 'say -v Kyoko "%%TEXT%%"'
"vim-colors-solarized
if has('mac')
  let g:solarized_termcolors=256
endif
syntax enable
set background=dark
colorscheme solarized

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインにショートカットを設定
"-------------------------------------------------------------------------------
" twitvim
nnoremap <C-i><C-t> :<C-u>CPosttoTwitter<CR>
nnoremap <C-i><C-f> :<C-u>Unite buffer file file_mru<CR>
nnoremap <C-i><C-i> :<C-u>TagbarToggle<CR>
" ref.vim
nnoremap <Leader>en :<C-u>Ref webdict en<Space>
nnoremap <Leader>en2 :<C-u>Ref webdict en2<Space>
"nnoremap <Leader>e :<C-u>call ref#jump('normal', 'webdict', 'en')<CR>
nnoremap <Leader>wiki :<C-u>Ref webdict wiki<Space>

source $HOME/.vimrc_env

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

" VimShell
autocmd FileType vimshell
\ call vimshell#hook#add('chpwd' , 'my_vimshell_chpwd' , 'g:my_vimshell_chpwd')
\| call vimshell#hook#add('emptycmd', 'my_vimshell_emptycmd', 'g:my_vimshell_emptycmd')
\| call vimshell#hook#add('notfound', 'my_vimshell_notfound', 'g:my_vimshell_notfound')

" シンタックスハイライトオン
"syntax on
