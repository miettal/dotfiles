fish_vi_key_bindings
set -g theme_color_scheme dracula

set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.local/bin $PATH

#set -g theme_display_git_dirty no
set -g theme_date_format "+%Y%m%d %H:%M:%S"

set -x EDITOR vim
set -x LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

alias commit='git add .; git commit . -m "quick commit"; git push'
alias vi='vim'
alias rm='trash'

if status is-interactive
and not set -q TMUX
    tmux attach -t base; or tmux new -s base
end
