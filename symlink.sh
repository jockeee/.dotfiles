#!/usr/bin/env bash

# ~/.local/bin
if ! [ -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
fi

# bash
if [ -d ~/.config/bash ]; then
    echo "[skip]: ~/.config/bash"
else
    echo -n "[info]: ~/.config/bash... "
    mkdir -p ~/.config/bash
    ln -s ~/.dotfiles/bash/bashrc ~/.config/bash/.
    ln -s ~/.dotfiles/bash/bash_aliases ~/.config/bash/.
    echo "OK"
fi
if [ -f ~/.bashrc ] && grep -q "# default distro ~/.bashrc above" ~/.bashrc; then
    echo "[skip]: ~/.bashrc"
else
    echo -n "[info]: ~/.bashrc... "
    cat >>~/.bashrc <<EOF

# default distro ~/.bashrc above

export XDG_CONFIG_HOME="\${XDG_CONFIG_HOME:-\$HOME/.config}"

if [ -f "\$XDG_CONFIG_HOME/bash/bashrc" ]; then
    source "\$XDG_CONFIG_HOME/bash/bashrc"
fi
EOF
    echo "OK"
fi

# bat
if [ -d ~/.config/bat ]; then
    echo "[skip]: ~/.config/bat"
else
    echo -n "[info]: ~/.config/bat... "
    ln -s ~/.dotfiles/bat ~/.config/.
    if command -v bat &>/dev/null; then
        /usr/bin/bat cache --build
    fi
    echo "OK"
fi

# eza
if [ -d ~/.config/eza ]; then
    echo "[skip]: ~/.config/eza"
else
    echo -n "[info]: ~/.config/eza... "
    ln -s ~/.dotfiles/eza ~/.config/.
    echo "OK"
fi

# fish
if [ -d ~/.config/fish ]; then
    echo "[skip]: ~/.config/fish"
else
    echo -n "[info]: ~/.config/fish... "
    mkdir -p ~/.config/fish
    ln -s ~/.dotfiles/fish/alias.fish ~/.config/fish/.
    ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/.
    echo "OK"
fi

# hidden
if [ -f ~/.hidden ]; then
    echo "[skip]: ~/.hidden"
else
    echo -n "[info]: ~/.hidden... "
    ln -s ~/.dotfiles/.hidden ~/.
    echo "OK"
fi

# lazygit
if [ -d ~/.config/lazygit ]; then
    echo "[skip]: ~/.config/lazygit"
else
    echo -n "[info]: ~/.config/lazygit... "
    ln -s ~/.dotfiles/lazygit ~/.config/.
    echo "OK"
fi

# nvim
if [ -d ~/.config/nvim ]; then
    echo "[skip]: ~/.config/nvim"
else
    echo -n "[info]: ~/.config/nvim... "
    ln -s ~/.dotfiles/nvim ~/.config/.
    echo "OK"
fi

# tmux
# if [ -d ~/.config/tmux ]; then
#     echo "[skip]: ~/.config/tmux"
# else
#     echo -n "[info]: ~/.config/tmux... "
#     mkdir -p ~/.config/tmux
#     ln -s ~/.dotfiles/tmux/tmux.conf ~/.config/tmux/.
#
#     if command -v git &>/dev/null; then
#         git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
#     fi
#     echo "OK"
# fi

# tmux-sessionizer
# if [ -f ~/.local/bin/tmux-sessionizer.sh ]; then
#     echo "[skip]: ~/.local/bin/tmux-sessionizer.sh"
# else
#     echo -n "[info]: ~/.local/bin/tmux-sessionizer.sh... "
#     ln -s ~/.dotfiles/bin/tmux-sessionizer.sh ~/.local/bin/.
#     echo "OK"
# fi

# wezterm
if [ -d ~/.config/wezterm ]; then
    echo "[skip]: ~/.config/wezterm"
else
    echo -n "[info]: ~/.config/wezterm... "
    ln -s ~/.dotfiles/wezterm ~/.config/.
    echo "OK"
fi

# zsh
if [ -d ~/.config/zsh ]; then
    echo "[skip]: ~/.config/zsh"
else
    echo -n "[info]: ~/.config/zsh... "
    mkdir -p ~/.config/zsh
    ln -s ~/.dotfiles/zsh/zsh ~/.config/zsh/.
    echo "OK"
fi

if [ -f ~/.zshrc ] && grep -q "# default distro ~/.zshrc above" ~/.zshrc; then
    echo "[skip]: ~/.zshrc"
else
    echo -n "[info]: ~/.zshrc... "
    cat >>~/.zshrc <<EOF

# default distro ~/.zshrc above

export XDG_CONFIG_HOME="\${XDG_CONFIG_HOME:-\$HOME/.config}"

if [ -f "\$XDG_CONFIG_HOME/zsh/zshrc" ]; then
    source "\$XDG_CONFIG_HOME/zsh/zshrc"
fi
EOF
    echo "OK"
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
