fish_vi_key_bindings

# # pyenv
# set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
# set -U fish_user_paths $HOME/.pyenv/shims $fish_user_paths
# . (pyenv init - --no-rehash | psub)
# # rbenv
# set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths
# set -U fish_user_paths $HOME/.rbenv/shims $fish_user_paths
# . (rbenv init - --no-rehash | psub)

alias commit='git add .; git commit . -m "quick commit"; git push'

if status is-interactive
and not set -q TMUX
    exec tmux
end
