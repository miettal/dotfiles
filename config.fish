fish_vi_key_bindings
set -g theme_color_scheme dracula

set -e fish_user_paths
set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths


fish_add_path /opt/homebrew/bin
eval (/opt/homebrew/bin/brew shellenv)
set prefix (brew --prefix)
# xz
export LDFLAGS="-L$prefix/opt/xz/lib $LDFLAGS"
export CPPFLAGS="-I$prefix/opt/xz/include $CPPFLAGS"
export PKG_CONFIG_PATH="$prefix/opt/xz/lib/pkgconfig:$PKG_CONFIG_PATH"
# openblas
export LDFLAGS="-L$prefix/opt/openblas/lib $LDFLAGS"
export CPPFLAGS="-I$prefix/opt/openblas/include $CPPFLAGS"
export PKG_CONFIG_PATH="$prefix/opt/openblas/lib/pkgconfig:$PKG_CONFIG_PATH"
# hdf5
export LDFLAGS="-L$prefix/opt/hdf5/lib $LDFLAGS"
export CPPFLAGS="-I$prefix/opt/hdf5/include $CPPFLAGS"
export PKG_CONFIG_PATH="$prefix/opt/hdf5/lib/pkgconfig:$PKG_CONFIG_PATH"
# openssl
export LDFLAGS="-L$prefix/opt/openssl/lib $LDFLAGS"
export CPPFLAGS="-I$prefix/opt/openssl/include $CPPFLAGS"
export PKG_CONFIG_PATH="$prefix/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH"

# set -g theme_display_git_dirty no
set -g theme_date_format "+%Y%m%d %H:%M:%S"

set -x EDITOR vim
set -x LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set -x LC_ALL en_US.UTF-8

set -x NODE_PATH /usr/local/lib/node_modules

alias commit='git add .; git commit; git push'
alias vi='vim'
alias rm='trash'

status is-interactive; and pyenv init --path | source
pyenv init - | source

if status is-interactive
and not set -q TMUX
    tmux attach -t base; or tmux new -s base
end
set -g fish_user_paths "/opt/homebrew/opt/pcsc-lite/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/opt/pcsc-lite/sbin" $fish_user_paths
 
# if test -d ~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/
#     set -x SSH_AUTH_SOCK /Users/taisyo/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
# end
