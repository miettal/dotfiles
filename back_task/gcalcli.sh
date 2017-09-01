export PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
eval "$(pyenv init -)"

gcalcli agenda --military > /tmp/com.miettal.gcalcli.$$
cp -f /tmp/com.miettal.gcalcli.$$ /tmp/com.miettal.gcalcli
