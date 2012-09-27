"-------------------------------------------------------------------------------
" 基本設定
"-------------------------------------------------------------------------------
" 判別不能のファイルをUTF-8で開く
set encoding=utf-8
" 判別の順番と読み込む文字コード
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" シンタックスハイライトオン
syntax on
" 行番号表示
set number
" タブ幅2
set tabstop=2
" オートインデントタブ幅2
set shiftwidth=2
" 検索結果をハイライトする
set hlsearch
" バックスペース設定
set backspace=indent,eol,start
" ステータスライン常に表示
set laststatus=2
" ステータスラインの内容
set statusline=%<%m%f%=%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%r%l/%L\ %{strftime('%H:%M')}
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
" 日本語vimdocを優先
set helplang=ja,en

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
autocmd Filetype c set cindent
autocmd Filetype cuda set cindent
autocmd Filetype cpp set cindent
" .vimperatorrc,_vimpeartorrcはvimrcとして扱う
autocmd BufNewFile,BufRead .vimperatorrc set filetype=vim
autocmd BufNewFile,BufRead _vimperatorrc set filetype=vim
" pythonのファイルはautoindentとsmartindentにする
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

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
Bundle 'snipMate'
Bundle 'Arduino-syntax-file'
Bundle 'HTML5-Syntax-File'
Bundle 'unite.vim'
Bundle 'TwitVim'
Bundle 'Gist.vim'
Bundle 'ref.vim'
Bundle 'sudo.vim'
Bundle 'vimpager'
Bundle 'TeTrIs.vim'
Bundle 'FastLadder.vim'
Bundle 'ack.vim'
"Bundle 'project.vim'
Bundle 'motemen/hatena-vim'
Bundle 'vim-jp/vimdoc-ja'
Bundle 'Lokaltog/vim-powerline'

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインの設定
"-------------------------------------------------------------------------------
" neocomplcacheを使用するための設定
let g:neocomplcache_enable_at_startup = 1
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
let g:neocomplcache_snippets_dir = $HOME . '.vim/bundle/snipMate/snippets'
" twitvim 旧式RT設定
"let twitvim_old_retweet = 1
" w3mがsegvするのでlynxを使う
let g:ref_alc_cmd='lynx -dump -nonumbers %s'
" .pdeをarduino-syntaxとして開く
autocmd BufNewFile,BufRead *.pde setlocal filetype=arduino
" powerlineの表示設定
let g:Powerline_symbols = 'compatible'

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインにショートカットを設定
"-------------------------------------------------------------------------------
" twitvimをマップ
nnoremap <C-i><C-t> :<C-u>CPosttoTwitter<CR>
" カーソル下のキーワードで辞典を引く
nnoremap <C-i><C-e> :<C-u>Ref<Space>alc<Space><C-r><C-w><CR>

"-------------------------------------------------------------------------------
" やる気を出す
"-------------------------------------------------------------------------------
autocmd VimEnter * echo "千里の道も一歩から．ガツガツコードを書こう！"
