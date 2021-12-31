fish_vi_key_bindings
set -g theme_color_scheme dracula

set -e fish_user_paths
set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths


fish_add_path /opt/homebrew/bin
eval (/opt/homebrew/bin/brew shellenv)
set prefix (brew --prefix)

fish_add_path /opt/homebrew/opt/bzip2/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/bzip2/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/bzip2/include"
fish_add_path /opt/homebrew/opt/bzip2/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/bzip2/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/bzip2/include"
fish_add_path /opt/homebrew/opt/hdf5/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/hdf5/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/hdf5/include"
fish_add_path /opt/homebrew/opt/openssl/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/openssl/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openssl/include"
fish_add_path /opt/homebrew/opt/openblas/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/openblas/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openblas/include"
fish_add_path /opt/homebrew/opt/xz/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/xz/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/xz/include"
fish_add_path /opt/homebrew/opt/libssh/bin
set -gx LDFLAGS "-L/opt/homebrew/opt/libssh/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/libssh/include"

set -x HDF5_DIR /opt/homebrew/opt/hdf5

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
