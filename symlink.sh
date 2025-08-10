#!/usr/bin/env bash

# ~/.local/bin
if [[ ! -d ~/.local/bin ]]; then
    mkdir -p ~/.local/bin
fi

# bash, ~/.config/bash
if [[ -d ~/.config/bash ]]; then
    echo -e "\e[33m[skip]: ~/.config/bash\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/bash"
    mkdir -p ~/.config/bash
    ln -s ~/.dotfiles/bash/bashrc ~/.config/bash/.
    ln -s ~/.dotfiles/bash/bash_aliases ~/.config/bash/.
fi
# bash, ~/.bashrc
if [[ -f ~/.bashrc ]] && grep -q "# default distro ~/.bashrc above" ~/.bashrc; then
    echo -e "\e[33m[skip]: ~/.bashrc\e[0m"
else
    echo -e "\e[32m[info]: ~/.bashrc \e[0m"
    cat >>~/.bashrc <<EOF

# default distro ~/.bashrc above

export XDG_CONFIG_HOME="\${XDG_CONFIG_HOME:-\$HOME/.config}"

if [[ -f "\$XDG_CONFIG_HOME/bash/bashrc" ]]; then
    source "\$XDG_CONFIG_HOME/bash/bashrc"
fi
EOF
fi

# bat
if [[ -e ~/.config/bat ]]; then
    echo -e "\e[33m[skip]: ~/.config/bat\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/bat\e[0m"
    ln -s ~/.dotfiles/bat ~/.config/.
    if command -v bat &>/dev/null; then
        /usr/bin/bat cache --build
    fi
fi

# eza
if [[ -e ~/.config/eza ]]; then
    echo -e "\e[33m[skip]: ~/.config/eza\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/eza\e[0m"
    ln -s ~/.dotfiles/eza ~/.config/.
fi

# fish
if [[ -e ~/.config/fish ]]; then
    echo -e "\e[33m[skip]: ~/.config/fish\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/fish\e[0m"
    mkdir -p ~/.config/fish
    ln -s ~/.dotfiles/fish/alias.fish ~/.config/fish/.
    ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/.
fi

# hidden
if [[ -e ~/.hidden ]]; then
    echo -e "\e[33m[skip]: ~/.hidden\e[0m"
else
    echo -e "\e[32m[info]: ~/.hidden\e[0m"
    ln -s ~/.dotfiles/.hidden ~/.
fi

# lazygit
if [[ -e ~/.config/lazygit ]]; then
    echo -e "\e[33m[skip]: ~/.config/lazygit\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/lazygit\e[0m"
    ln -s ~/.dotfiles/lazygit ~/.config/.
fi

# nvim
if [[ -e ~/.config/nvim ]]; then
    echo -e "\e[33m[skip]: ~/.config/nvim\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/nvim\e[0m"
    ln -s ~/.dotfiles/nvim ~/.config/.
fi

# tmux
# if [[ -e ~/.config/tmux ]]; then
#     echo -e "\e[33m[skip]: ~/.config/tmux\e[0m"
# else
#     echo -e "\e[32m[info]: ~/.config/tmux\e[0m"
#     mkdir -p ~/.config/tmux
#     ln -s ~/.dotfiles/tmux/tmux.conf ~/.config/tmux/.
#
#     if command -v git &>/dev/null; then
#         git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
#     fi
# fi

# tmux-sessionizer
# if [[ -e ~/.local/bin/tmux-sessionizer.sh ]]; then
#     echo -e "\e[33m[skip]: ~/.local/bin/tmux-sessionizer.sh\e[0m"
# else
#     echo -e "\e[32m[info]: ~/.local/bin/tmux-sessionizer.sh\e[0m"
#     ln -s ~/.dotfiles/bin/tmux-sessionizer.sh ~/.local/bin/.
# fi

# wezterm
if [[ -e ~/.config/wezterm ]]; then
    echo -e "\e[33m[skip]: ~/.config/wezterm\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/wezterm\e[0m"
    ln -s ~/.dotfiles/wezterm ~/.config/.
fi

# whatthecommit.com, wwd.py
if [[ -e ~/.local/bin/wwd.py ]]; then
    echo -e "\e[33m[skip]: ~/.local/bin/wwd.py\e[0m"
else
    echo -e "\e[32m[info]: ~/.local/bin/wwd.py\e[0m"
    ln -s ~/.dotfiles/wwd/wwd.py ~/.local/bin/.
fi

# zsh, ~/.config/zsh
if [[ -e ~/.config/zsh ]]; then
    echo -e "\e[33m[skip]: ~/.config/zsh\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/zsh\e[0m"
    mkdir -p ~/.config/zsh
    ln -s ~/.dotfiles/bash/bashrc ~/.config/zsh/zshrc
fi

# zsh, ~/.zshrc
if [[ -e ~/.zshrc ]] && grep -q "# default distro ~/.zshrc above" ~/.zshrc; then
    echo -e "\e[33m[skip]: ~/.zshrc\e[0m"
else
    echo -e "\e[32m[info]: ~/.zshrc\e[0m"
    cat >>~/.zshrc <<EOF

# default distro ~/.zshrc above

export XDG_CONFIG_HOME="\${XDG_CONFIG_HOME:-\$HOME/.config}"

if [[ -f "\$XDG_CONFIG_HOME/zsh/zshrc" ]]; then
    source "\$XDG_CONFIG_HOME/zsh/zshrc"
fi
EOF
fi
