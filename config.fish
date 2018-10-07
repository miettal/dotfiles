fish_vi_key_bindings

# pyenv
set -x PATH $HOME/.pyenv/bin $PATH
set -x PATH $HOME/.pyenv/shims $PATH
. (pyenv init - --no-rehash | psub)
#rbenv
set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.rbenv/shims $PATH
. (rbenv init - --no-rehash | psub)

alias commit='git add .; git commit . -m "quick commit"; git push'

if status is-interactive
and not set -q TMUX
    exec tmux
end
