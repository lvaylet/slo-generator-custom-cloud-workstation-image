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
command -v pyenv >/dev/null || curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
command -v pyenv >/dev/null || cat >> ~/.bashrc << EOF

# Pyenv
export PYENV_ROOT="\$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
EOF
