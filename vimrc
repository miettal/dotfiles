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

  call dein#add('~/.vim/dein//repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  endif
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/vimproc', {'build': 'make'})
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/context_filetype.vim')
  call dein#add('cocopon/vaffle.vim')
  call dein#add('thinca/vim-template')
  call dein#add('thinca/vim-quickrun')
  call dein#add('itchyny/lightline.vim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('w0rp/ale')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('honza/vim-snippets')
  call dein#add('rkitover/vimpager', {'build': 'chmod +x vimpager'})
  call dein#add('vim-scripts/sudo.vim')
  call dein#add('nathanaelkane/vim-indent-guides')

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
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_linters = {
\   'python': ['flake8'],
\}
" nerdtree
let g:NERDTreeShowHidden = 1
" deoplete
let g:deoplete#enable_at_startup = 1
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

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインにショートカットを設定
"-------------------------------------------------------------------------------
"nothing

"-------------------------------------------------------------------------------
" テンプレート
"-------------------------------------------------------------------------------
" タブ保管
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
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

syntax enable
