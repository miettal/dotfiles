fish_vi_key_bindings
set -g theme_color_scheme dracula

set -e fish_user_paths
set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths



fish_add_path /opt/homebrew/bin
eval (/opt/homebrew/bin/brew shellenv)
set prefix (brew --prefix)

fish_add_path $HOME/.nodebrew/current/bin
fish_add_path /opt/homebrew/opt/libpq/bin
# 
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/bzip2/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/llvm/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/hdf5/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/openssl@3/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/openblas/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/lapack/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/xz/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/libssh/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/libtiff/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/eccodes/lib/pkgconfig"
# set -gx LDFLAGS "-L/opt/homebrew/opt/.../lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/.../include
# set -gx CFLAGS "-I/opt/homebrew/opt/.../include

set -gx HDF5_DIR /opt/homebrew/opt/hdf5
set -gx OPENBLAS /opt/homebrew/opt/openblas

set -g theme_date_format "+%Y%m%d %H:%M:%S"

set -x EDITOR nvim
set -x LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set -x LC_ALL en_US.UTF-8

set -x NODE_PATH /usr/local/lib/node_modules

alias commit='git add .; git commit; git push'
alias vi='nvim'
alias rm='trash'
alias ls='lsd'

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
