export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
eval "$(pyenv init -)"

gcalcli agenda > /tmp/com.miettal.gcalcli.$$
cp -f /tmp/com.miettal.gcalcli.$$ /tmp/com.miettal.gcalcli
