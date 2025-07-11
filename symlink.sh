#!/usr/bin/env bash

# ~/.local/bin
if ! [ -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
fi

# bash
if [ -d ~/.config/bash ]; then
    echo -e "\e[33m[skip]: ~/.config/bash\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/bash"
    mkdir -p ~/.config/bash
    ln -s ~/.dotfiles/bash/bashrc ~/.config/bash/.
    ln -s ~/.dotfiles/bash/bash_aliases ~/.config/bash/.
fi
# ~/.bashrc
if [ -f ~/.bashrc ] && grep -q "# default distro ~/.bashrc above" ~/.bashrc; then
    echo -e "\e[33m[skip]: ~/.bashrc\e[0m"
else
    echo -e "\e[32m[info]: ~/.bashrc \e[0m"
    cat >>~/.bashrc <<EOF

# default distro ~/.bashrc above
export XDG_CONFIG_HOME="\${XDG_CONFIG_HOME:-\$HOME/.config}"
if [ -f "\$XDG_CONFIG_HOME/bash/bashrc" ]; then
    source "\$XDG_CONFIG_HOME/bash/bashrc"
fi
EOF
fi

# bat
if [ -d ~/.config/bat ]; then
    echo -e "\e[33m[skip]: ~/.config/bat\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/bat\e[0m"
    ln -s ~/.dotfiles/bat ~/.config/.
    if command -v bat &>/dev/null; then
        /usr/bin/bat cache --build
    fi
fi

# eza
if [ -d ~/.config/eza ]; then
    echo -e "\e[33m[skip]: ~/.config/eza\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/eza\e[0m"
    ln -s ~/.dotfiles/eza ~/.config/.
fi

# fish
if [ -d ~/.config/fish ]; then
    echo -e "\e[33m[skip]: ~/.config/fish\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/fish\e[0m"
    mkdir -p ~/.config/fish
    ln -s ~/.dotfiles/fish/alias.fish ~/.config/fish/.
    ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/.
fi

# hidden
if [ -f ~/.hidden ]; then
    echo -e "\e[33m[skip]: ~/.hidden\e[0m"
else
    echo -e "\e[32m[info]: ~/.hidden\e[0m"
    ln -s ~/.dotfiles/.hidden ~/.
fi

# lazygit
if [ -d ~/.config/lazygit ]; then
    echo -e "\e[33m[skip]: ~/.config/lazygit\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/lazygit\e[0m"
    ln -s ~/.dotfiles/lazygit ~/.config/.
fi

# nvim
if [ -d ~/.config/nvim ]; then
    echo -e "\e[33m[skip]: ~/.config/nvim\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/nvim\e[0m"
    ln -s ~/.dotfiles/nvim ~/.config/.
fi

# tmux
# if [ -d ~/.config/tmux ]; then
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
# if [ -f ~/.local/bin/tmux-sessionizer.sh ]; then
#     echo -e "\e[33m[skip]: ~/.local/bin/tmux-sessionizer.sh\e[0m"
# else
#     echo -e "\e[32m[info]: ~/.local/bin/tmux-sessionizer.sh\e[0m"
#     ln -s ~/.dotfiles/bin/tmux-sessionizer.sh ~/.local/bin/.
# fi

# wezterm
if [ -d ~/.config/wezterm ]; then
    echo -e "\e[33m[skip]: ~/.config/wezterm\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/wezterm\e[0m"
    ln -s ~/.dotfiles/wezterm ~/.config/.
fi

# ~/.config/zsh
if [ -d ~/.config/zsh ]; then
    echo -e "\e[33m[skip]: ~/.config/zsh\e[0m"
else
    echo -e "\e[32m[info]: ~/.config/zsh\e[0m"
    mkdir -p ~/.config/zsh
    ln -s ~/.dotfiles/bash/bashrc ~/.config/zsh/zshrc
fi

# ~/.zshrc
if [ -f ~/.zshrc ] && grep -q "# default distro ~/.zshrc above" ~/.zshrc; then
    echo -e "\e[33m[skip]: ~/.zshrc\e[0m"
else
    echo -e "\e[32m[info]: ~/.zshrc\e[0m"
    cat >>~/.zshrc <<EOF

# default distro ~/.zshrc above
export XDG_CONFIG_HOME="\${XDG_CONFIG_HOME:-\$HOME/.config}"
if [ -f "\$XDG_CONFIG_HOME/zsh/zshrc" ]; then
    source "\$XDG_CONFIG_HOME/zsh/zshrc"
fi
EOF
fi

# #!/usr/bin/env bash
#
# # ~/.local/bin
# if ! [ -d ~/.local/bin ]; then
#     mkdir -p ~/.local/bin
# fi
#
# # wezterm
# mkdir -p ~/.config/wezterm
# ln -s ~/.dotfiles/wezterm/wezterm.lua ~/.config/wezterm/.
# ln -s ~/.dotfiles/wezterm/wezterm-notmux.lua ~/.config/wezterm/.
# ln -s ~/.dotfiles/wezterm/utils.lua ~/.config/wezterm/.
# ln -s ~/.dotfiles/wezterm/.style.lua ~/.config/wezterm/.
#
# # bash
# if ! grep -q "# default .bashrc above" ~/.bashrc; then
#     cat >>~/.bashrc <<EOF
#
# # default .bashrc above
# if [ -f "$HOME/.dotfiles/.bashrc" ]; then
#     . "$HOME/.dotfiles/.bashrc"
# fi
# EOF
# fi
#
# # fish
# mkdir -p ~/.config/fish
# ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/.
# ln -s ~/.dotfiles/fish/alias.fish ~/.config/fish/.
#
# # tmux
# if [ -d ~/.config/tmux ]; then
#     echo "[info]: ~/.config/tmux already exists, skipping symlink creation."
# else
#     mkdir -p ~/.config/tmux
#     ln -s ~/.dotfiles/tmux/tmux.conf ~/.config/tmux/.
#
#     if command -v git &>/dev/null; then
#         git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
#     fi
# fi
#
# # tmux-sessionizer
# ln -s ~/.dotfiles/bin/tmux-sessionizer.sh ~/.local/bin/.
#
# # nvim
# ln -s ~/.dotfiles/nvim ~/.config/.
#
# # bat
# ln -s ~/.dotfiles/bat ~/.config/.
# if command -v bat &>/dev/null; then
#     /usr/bin/bat cache --build
# fi
#
# # eza
# ln -s ~/.dotfiles/eza ~/.config/.
#
# # hidden
# ln -s ~/.dotfiles/.hidden ~/.
