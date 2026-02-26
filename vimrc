"-------------------------------------------------------------------------------
" 基本設定
"-------------------------------------------------------------------------------
" encoding
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set nocompatible
" style
set number
set list
set laststatus=2
set colorcolumn=120
" search
set incsearch
set hlsearch
set ignorecase
set smartcase
" tab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
" バックスペース設定
set backspace=indent,eol,start
" バッファを閉じる代わりに隠す（Undo履歴を残すため）
set hidden
" zsh風の補完候補表示
set wildmode=list:longest
" 入力中のコマンド表示
set showcmd
" *.texはlatexファイルタイプで開く
let g:tex_flavor = "latex"
" 全角幅の記号正しく表示する
set ambiwidth=double
colorscheme koehler
set shortmess+=I

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

" 

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
    Plug 'is0n/jaq-nvim'
    Plug 'thinca/vim-quickrun'
    Plug 'Shougo/vimproc', {'do' : 'make'}

    " appearance
    Plug 'w0ng/vim-hybrid'
    Plug 'itchyny/lightline.vim'
    Plug 'nathanaelkane/vim-indent-guides'

    " autocomplete
    Plug 'Shougo/ddc.vim'
    Plug 'vim-denops/denops.vim'
    Plug 'Shougo/ddc-ui-native'
    Plug 'Shougo/ddc-source-around'
    Plug 'Shougo/ddc-matcher_head'
    Plug 'Shougo/ddc-sorter_rank'

    " *env
    Plug 'lambdalisue/vim-pyenv'
    Plug 'tpope/vim-rbenv'
 
    " lsp
    Plug 'prabirshrestha/vim-lsp'
    " Plug 'mattn/vim-lsp-settings'

    " git
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/committia.vim'

    " other
    Plug 'tweekmonster/braceless.vim'
    Plug 'hashivim/vim-terraform'

"   Plug 'dense-analysis/ale'
"   Plug 'othree/yajs.vim'
"   Plug 'maxmellon/vim-jsx-pretty'
"   Plug 'hashivim/vim-terraform'
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

if &compatible
  set nocompatible
endif

set background=dark
colorscheme hybrid

filetype plugin indent on
syntax enable

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
" ddc
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['around'])
call ddc#custom#patch_global('sourceOptions', #{
      \ _: #{
      \   matchers: ['matcher_head'],
      \   sorters: ['sorter_rank']},
      \ })
call ddc#custom#patch_global('sourceOptions', #{
      \   around: #{ mark: 'A' },
      \ })
call ddc#custom#patch_global('sourceParams', #{
      \   around: #{ maxSize: 500 },
      \ })
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources',
      \ ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', #{
      \   clangd: #{ mark: 'C' },
      \ })
" call ddc#custom#patch_filetype('markdown', 'sourceParams', {
"       \   around: #{ maxSize: 100 },
"       \ })
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

call ddc#enable()

" vim-gitgutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_highlight_lines = 1
" committia.vim
let g:committia_open_only_vim_starting = 0
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
" braceless.vim
autocmd FileType python BracelessEnable +fold +highlight-cc2

"-------------------------------------------------------------------------------
" Vundleでインストールしたプラグインにショートカットを設定
"-------------------------------------------------------------------------------
nnoremap \r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap \r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>

"-------------------------------------------------------------------------------
" Load other vimrc
"-------------------------------------------------------------------------------
source $HOME/.vimrc_env

syntax enable
