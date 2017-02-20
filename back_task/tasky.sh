export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
eval "$(pyenv init -)"

python $HOME/.tasky/tasky.py --list > /tmp/com.miettal.tasky.$$
cp -f /tmp/com.miettal.tasky.$$ /tmp/com.miettal.tasky
