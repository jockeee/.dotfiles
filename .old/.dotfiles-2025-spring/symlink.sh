#!/usr/bin/env bash

# ~/.local/bin
if ! [ -d ~/.local/bin ]; then
    mkdir -p ~/.local/bin
fi

# wezterm
if [ -d ~/.config/wezterm ]; then
    echo "[info]: ~/.config/wezterm already exists, skipping symlink creation."
else
    ln -s ~/.dotfiles/wezterm ~/.config/.
fi

# bash
if ! grep -q "# default distro ~/.bashrc above" ~/.bashrc; then
    cat >>~/.bashrc <<EOF

# default distro ~/.bashrc above
if [ -f "$HOME/.dotfiles/.bashrc" ]; then
    . "$HOME/.dotfiles/.bashrc"
fi
EOF
fi

# fish
if [ -d ~/.config/fish ]; then
    echo "[info]: ~/.config/fish already exists, skipping symlink creation."
else
    mkdir -p ~/.config/fish
    ln -s ~/.dotfiles/fish/alias.fish ~/.config/fish/.
    ln -s ~/.dotfiles/fish/config.fish ~/.config/fish/.
fi

# tmux
if [ -d ~/.config/tmux ]; then
    echo "[info]: ~/.config/tmux already exists, skipping symlink creation."
else
    mkdir -p ~/.config/tmux
    ln -s ~/.dotfiles/tmux/tmux.conf ~/.config/tmux/.

    if command -v git &>/dev/null; then
        git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    fi
fi

# tmux-sessionizer
if [ -f ~/.local/bin/tmux-sessionizer.sh ]; then
    echo "[info]: ~/.local/bin/tmux-sessionizer.sh already exists, skipping symlink creation."
else
    ln -s ~/.dotfiles/bin/tmux-sessionizer.sh ~/.local/bin/.
fi

# nvim
if [ -d ~/.config/nvim ]; then
    echo "[info]: ~/.config/nvim already exists, skipping symlink creation."
else
    ln -s ~/.dotfiles/nvim ~/.config/.
fi

# bat
if [ -d ~/.config/bat ]; then
    echo "[info]: ~/.config/bat already exists, skipping symlink creation."
else
    ln -s ~/.dotfiles/bat ~/.config/.
    if command -v bat &>/dev/null; then
        /usr/bin/bat cache --build
    fi
fi

# eza
if [ -d ~/.config/eza ]; then
    echo "[info]: ~/.config/eza already exists, skipping symlink creation."
else
    ln -s ~/.dotfiles/eza ~/.config/.
fi

# hidden
if [ -f ~/.hidden ]; then
    echo "[info]: ~/.config/hidden already exists, skipping symlink creation."
else
    ln -s ~/.dotfiles/.hidden ~/.
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
