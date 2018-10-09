fish_vi_key_bindings

alias commit='git add .; git commit . -m "quick commit"; git push'

if status is-interactive
and not set -q TMUX
    exec tmux
end
