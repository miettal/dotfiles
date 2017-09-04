export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
eval "$(pyenv init -)"
export LC_ALL="ja_JP.UTF-8"

gcalcli agenda --military > /tmp/com.miettal.gcalcli.$$
cp -f /tmp/com.miettal.gcalcli.$$ /tmp/com.miettal.gcalcli
