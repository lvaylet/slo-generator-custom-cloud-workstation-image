#!/bin/bash

echo "Running as user $(whoami)"
echo "HOME=$HOME"

# Configure git (if not already configured).
[[ -f $HOME/.gitconfig ]] || cat << EOF > $HOME/.gitconfig
[user]
    name = Laurent VAYLET
    email = laurent.vaylet@gmail.com
[pull]
    rebase = true
EOF

# Install and configure Pyenv (if not already installed).
if ! command -v pyenv &> /dev/null
then
    echo "pyenv could not be found"
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    cat >> ~/.profile << EOF

# Pyenv
export PYENV_ROOT="\$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
EOF
fi
