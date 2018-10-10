fish_vi_key_bindings
set -g theme_color_scheme dracula
set -g LSCOLORS gxfxbEaEBxxEhEhBaDaCaD

alias commit='git add .; git commit . -m "quick commit"; git push'

if status is-interactive
and not set -q TMUX
    exec tmux
end
