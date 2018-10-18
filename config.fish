fish_vi_key_bindings
set -g theme_color_scheme dracula

set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

set -x EDITOR vim
set -x LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

alias commit='git add .; git commit . -m "quick commit"; git push'
alias vi='vim'

if status is-interactive
and not set -q TMUX
    exec tmux
end
