fish_vi_key_bindings
set -g theme_color_scheme dracula

set -e fish_user_paths
set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

eval (/opt/homebrew/bin/brew shellenv)
set -x LD_LIBRARY_PATH /opt/homebrew/lib/
set -x DYLD_LIBRARY_PATH /opt/homebrew/lib/

# set -g theme_display_git_dirty no
set -g theme_date_format "+%Y%m%d %H:%M:%S"

set -x EDITOR vim
set -x LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set -x PYENV_PATH $HOME/.pyenv
set -x LC_ALL en_US.UTF-8

set -x NODE_PATH /usr/local/lib/node_modules

alias commit='git add .; git commit; git push'
alias vi='vim'
alias rm='trash'

if status is-interactive
and not set -q TMUX
    tmux attach -t base; or tmux new -s base
end
set -g fish_user_paths "/opt/homebrew/opt/pcsc-lite/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/opt/pcsc-lite/sbin" $fish_user_paths
