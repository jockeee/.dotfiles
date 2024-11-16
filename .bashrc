# default distro ~/.bashrc above
# VERSION 1.0.22

##
## Environment
##

if [ -z "$TMUX_DEFAULT_SESSION_NAME" ]; then
    TMUX_DEFAULT_SESSION_NAME=$(uname -n)
fi

##
## ALIAS
##

# ls options
#   -A, --almost-all: do not list implied . and ..
alias l='ls -l'
alias la='ls -lA'
alias ld='ls -ld'
alias laa='ls -la'
alias laz='ls -laZ'
alias ladz='ls -ladZ'
alias lazd='ls -ladZ'
alias man='man --nj'
alias wezterm='flatpak run org.wezfurlong.wezterm'

if type -P btop &>/dev/null; then
    alias top='btop'
fi

if type -P eza &>/dev/null; then
    # Filtering options
    #   Pass the -a, --all option twice to also show the . and .. directories.
    # Long view options
    #   -a, --all: show hidden and 'dot' files
    #   -g, --group: list each file’s group
    #   --git: list each file’s Git status, if tracked or ignored
    alias ls='eza -g --git'
    alias la='eza -gla --git'
    alias ld='eza -gld --git'
    alias laa='eza -glaa --git'
    alias tree='eza -aT --git-ignore'
fi

if type -P pass &>/dev/null; then
    alias p='pass show -c'
    alias pe='pass edit'
    alias pf='pass find'
    alias pg='pass generate -c -i'
    alias pi='pass insert -m'
fi

# .
alias c='cat'
alias g='git'
alias t='tree'
alias v='vim'

# tmux
# https://github.com/lewisacidic/fish-tmux-abbr
alias s='tmux attach || tmux new-session -s $TMUX_DEFAULT_SESSION_NAME'
alias ss='tmux new-session -A -s'
alias sx='tmux kill-session -t'
alias sl='tmux list-sessions'

# git
# https://github.com/lewisacidic/fish-git-abbr
alias d='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gl='git log'
alias gp='git push'
alias gpl='git pull'
alias gr='git remote -v'
alias grs='git reset'
alias grs!='git reset --hard'
alias gs='git status'

if type -P git-forgit &>/dev/null; then
    # alias d='git-forgit diff'
    alias gd='git-forgit diff'
    alias gl='git-forgit log'
fi

if type -P bat &>/dev/null; then
    bat_cmd='bat'
    alias bat='bat -pp'
    alias c='bat -pp'
    alias d='batdiff'
fi

if type -P batcat &>/dev/null; then
    bat_cmd='batcat'
    alias bat='batcat -pp'
    alias c='batcat -pp'
    alias d='batdiff'
fi

if type -P npm &>/dev/null; then
    alias n='npm'
fi

if type -P pnpm &>/dev/null; then
    alias n='pnpm'
    alias npm='pnpm'
fi

##
## Functions
##

# You like the output of batdiff for quick overview.
batdiff() {
    if ! is_git_repo; then
        echo 'Error: Unable to locate a Git repository.'
        return 1
    fi

    git diff --name-only --relative --diff-filter=d "$@" | xargs "$bat_cmd" --diff
}

cdg() {
    if ! is_git_repo; then
        echo 'Error: Unable to locate a Git repository.'
        return 1
    fi

    git_dir=$(git rev-parse --show-toplevel)
    if [ -n "$git_dir" ]; then
        cd "$git_dir" || return 1
    fi
}

# https://github.com/oh-my-fish/oh-my-fish/blob/master/lib/git/git_is_repo.fish
is_git_repo() {
    if [ -d .git ]; then
        return 0
    fi

    local info
    if info=$(git rev-parse --git-dir --is-bare-repository 2>/dev/null); then
        IFS=' ' read -r git_dir is_bare <<<"$info"

        if [ "$is_bare" = "false" ]; then
            return 0
        fi
    fi

    return 1
}

# gg (git add, git commit, git push)
# usage: gg [commit message]
gg() {
    if ! is_git_repo; then
        echo 'Error: Unable to locate a Git repository.'
        return 1
    fi

    use_ai=0

    if [ $# -eq 0 ]; then
        if type -P aicommits &>/dev/null; then
            use_ai=1
        else
            echo "Usage: gg [commit message]"
            echo "Info: aicommits not present"
            return 1
        fi
    fi

    if [ $use_ai -eq 1 ]; then
        # using aicomments
        # echo statements has bold text
        echo -e "\e[1mgit add -A\e[0m" && git add -A &&
            echo -e "\e[1maicommits\e[0m" && aicommits &&
            echo -e "\e[1mgit push\e[0m" && git push
    else
        # using user supplied commit message
        # echo statements has bold text
        echo -e "\e[1mgit add -A\e[0m" && git add -A &&
            echo -e "\e[1mgit commit -m \"$1\"\e[0m" && git commit -m "$1" &&
            echo -e "\e[1mgit push\e[0m" && git push
    fi
}

# ww (git add, git commit, git push - whatthecommit.com)
# usage: ww
# like gg but random commit message from whatthecommit.com
ww() {
    if ! is_git_repo; then
        echo 'Error: Unable to locate a Git repository.'
        return 1
    fi

    if ! type -P curl &>/dev/null; then
        echo "Error: Unable to locate 'curl'"
        return 1
    fi

    continue='n'
    while [ "$continue" != "y" ] && [ "$continue" != "Y" ]; do
        local message
        if ! message=$(curl -s https://whatthecommit.com/index.txt); then
            echo "Error: Couldn't retrieve a commit message from 'whatthecommit.com'"
            return 1
        fi

        echo "Commit message: $message"
        read -r -p "Do you want to use this commit message? [y/N/q]: " continue
        if [ "$continue" = "q" ]; then
            return 0
        fi
    done

    # echo statements has bold text
    echo -e "\e[1mgit add -A\e[0m" && git add -A &&
        echo -e "\e[1mgit commit -m \"$message\"\e[0m" && git commit -m "$message" &&
        echo -e "\e[1mgit push\e[0m" && git push
}

# git-tidy (Git History Cleanup)
alias gt='git-tidy'
git-tidy() {
    if ! is_git_repo; then
        echo 'Error: Unable to locate a Git repository.'
        return 1
    fi

    read -r -p "Remove all Git history in this repo? [y/N]: "
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return 0
    fi

    # Create Backup
    echo -e '\n\n\e[1mCreate Backup\e[0m\n'
    local backup_dir
    if ! backup_dir=$(mktemp -d); then
        echo "Error: Couldn't create backup directory"
        return 1
    fi

    if ! git clone --mirror . "$backup_dir"; then
        echo "Error: Couldn't create backup"
        rm -rf "$backup_dir"
        return 1
    fi

    # Git History Cleanup
    echo -e '\n\n\e[1mGit History Cleanup\e[0m\n'
    git checkout --orphan latest_commit &&
        git add -A &&
        git commit -m "Git History Cleanup" | grep -v " create mode " &&
        git branch -D main &&
        git branch -m main

    if [[ $? -ne 0 ]]; then
        echo "Error: Couldn't clean up Git history"
        echo "Info: Backup available at $backup_dir"
        git checkout main
        git branch -D latest_commit
        return 1
    fi
    echo "Info: Branch 'latest_commit' renamed to 'main'"

    # Push to Remote
    echo -e '\n\n\e[1mPush to Remote\e[0m\n'
    read -r -p "Push to Remote? [Y/n]: "
    if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]; then
        git push -f --set-upstream origin main
    fi

    # Remove Backup
    echo -e '\n\n\e[1mRemove Backup\e[0m\n'
    read -r -p "Remove Backup? [Y/n]: "
    if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]; then
        echo "Info: Removing $backup_dir"
        rm -rf "$backup_dir"
    else
        echo "Info: Backup available at $backup_dir"
    fi

    # Git Log
    echo -e '\n\n\e[1mNew Git Log\e[0m\n'
    git log
    echo
}

upd_fedora() {
    echo -e '\e[1mUpdating system\e[0m'
    echo -e '\e[3msudo dnf upgrade\e[0m\n'
    sudo /usr/bin/dnf upgrade -y
    echo
    if type -P /usr/bin/flatpak &>/dev/null; then
        echo -e '\e[1mUpdating flatpak apps\e[0m'
        echo -e '\e[3mflatpak update\e[0m\n'
        /usr/bin/flatpak update -y
        echo
    fi
    upd_go
    upd_npm
}

upd_ubuntu() {
    echo -e '\e[1mUpdating system\e[0m'
    echo -e '\e[3msudo apt update, sudo apt full-upgrade, sudo apt autoremove\e[0m\n'
    sudo /usr/bin/apt update
    sudo /usr/bin/apt full-upgrade -y
    sudo /usr/bin/apt autoremove -y
    echo
    if type -P /usr/bin/snap &>/dev/null; then
        echo -e '\e[1mUpdating snap apps\e[0m'
        echo -e '\e[3msudo snap refresh\e[0m\n'
        sudo /usr/bin/snap refresh # requires sudo unless authenticated to a Ubuntu One/SSO account
        echo
    fi
    upd_go
    upd_npm
}

upd_npm() {
    if type -P /usr/local/bin/npm &>/dev/null; then
        echo -e '\e[1mUpdating npm\e[0m'
        echo -e '\e[3msudo npm install -g npm@latest\e[0m'
        sudo /usr/local/bin/npm install -g npm@latest
        echo
        echo "NPM version: $(/usr/local/bin/npm --version)"
        echo
    fi
}

upd_go() {
    if type -P /usr/local/go/bin/go &>/dev/null; then
        echo -e '\e[1mUpdating Go\e[0m'
        echo -e '\e[3mhttps://go.dev/dl\e[0m'
        echo

        if ! type -P /usr/bin/curl &>/dev/null; then
            echo "Error: 'curl' not found"
            return 1
        fi

        if ! type -P /usr/bin/jq &>/dev/null; then
            echo "Error: 'jq' not found"
            return 1
        fi

        os=$(uname -s | tr '[:upper:]' '[:lower:]')
        arch=$(uname -m)
        if [ "$arch" == 'x86_64' ]; then
            arch='amd64'
        fi
        kind='archive'
        temp_file="/tmp/tmp.golang_install"
        download_url_base='https://golang.org/dl/'

        # download json
        local go_dev_json
        # go_dev_json=$(curl -s https://go.dev/dl/?mode=json)
        # go_dev_json=$(wget -qO- https://go.dev/dl/?mode=json)
        if ! go_dev_json=$(curl -s https://go.dev/dl/?mode=json); then
            echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
            rm $temp_file
            return 1
        fi

        current_go_version=$(/usr/local/go/bin/go version | awk '{print $3}')
        latest_go_version=$(echo "$go_dev_json" | jq -r '.[0].version')

        current_major=$(echo "$current_go_version" | sed 's/go//' | cut -d. -f1)
        current_minor=$(echo "$current_go_version" | sed 's/go//' | cut -d. -f2)
        current_patch=$(echo "$current_go_version" | sed 's/go//' | cut -d. -f3)

        latest_major=$(echo "$latest_go_version" | sed 's/go//' | cut -d. -f1)
        latest_minor=$(echo "$latest_go_version" | sed 's/go//' | cut -d. -f2)
        latest_patch=$(echo "$latest_go_version" | sed 's/go//' | cut -d. -f3)

        need_update=false
        if [ "$current_major" -lt "$latest_major" ]; then
            need_update=true
        elif [ "$current_major" -eq "$latest_major" ]; then
            if [ "$current_minor" -lt "$latest_minor" ]; then
                need_update=true
            elif [ "$current_minor" -eq "$latest_minor" ]; then
                if [ "$current_patch" -lt "$latest_patch" ]; then
                    need_update=true
                fi
            fi
        fi

        selected_json=$(echo "$go_dev_json" | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_go_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

        # if selected_json isn't empty, set download_filename and download_checksum
        if [ -n "$selected_json" ]; then
            download_filename=$(echo "$selected_json" | jq -r '.filename')
            download_checksum=$(echo "$selected_json" | jq -r '.sha256')
        else
            echo "Error: Couldn't find the latest version for $os-$arch in the JSON response."
            return 1
        fi

        if [ $need_update == true ]; then
            echo "Update available: $current_go_version -> $latest_go_version"
            echo

            # read -r -p "Do you want to update? [y/N] "
            # if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            #   return 0
            # fi
            # echo

            # Download go
            # curl -L -o "$temp_file $download_url_base$download_filename"
            # wget -q --show-progress -O "$temp_file $download_url_base$download_filename"
            if ! curl -L -o "$temp_file $download_url_base$download_filename"; then
                echo "Error: Download failed."
                if [ -e $temp_file ]; then
                    rm $temp_file
                fi
                return 1
            fi

            if [ ! -e $temp_file ]; then
                echo "Error: Couldn't find the downloaded file."
                return 1
            fi

            # Verify checksum
            checksum=$(sha256sum $temp_file | cut -d' ' -f1)
            if [ "$checksum" != "$download_checksum" ]; then
                echo "Error: Checksum verification failed"
                rm $temp_file
                return 1
            fi

            # Update
            sudo rm -rf /usr/local/go
            sudo tar -C /usr/local -xzf $temp_file
            rm $temp_file
        else
            echo "No update available"
        fi

        echo
        echo "Go version: $(/usr/local/go/bin/go version | awk '{print $3}')"
        echo
    fi
}

upd_bashrc() {
    echo -e '\e[1mUpdating ~/.bashrc\e[0m\n'

    if [ ! -e ~/.dotfiles/.bashrc ]; then
        echo "Error: Couldn't find ~/.dotfiles/.bashrc"
        return 1
    fi

    # create backup
    if [ -e ~/.bashrc ]; then
        cp ~/.bashrc ~/.bashrc.bak
    fi

    # remove current additions
    if ! sed -i '/# default distro ~\/.bashrc above/,$ d' ~/.bashrc; then
        echo "Error: Couldn't clean ~/.bashrc from current additions."
        mv ~/.bashrc.bak ~/.bashrc
        return 1
    fi

    # add new additions
    if ! cat ~/.dotfiles/.bashrc >>~/.bashrc; then
        echo "Error: Couldn't update ~/.bashrc"
        mv ~/.bashrc.bak ~/.bashrc
        return 1
    fi

    # source ~/.bashrc
    if ! source "$HOME/.bashrc"; then
        echo "Error: Couldn't source ~/.bashrc"
        mv ~/.bashrc.bak ~/.bashrc
        return 1
    fi

    rm -f ~/.bashrc.bak

    echo "Version: $(grep -E "^# VERSION" ~/.bashrc | cut -d' ' -f3)"
    echo
}

# zoxide, smarter cd
if type -P /usr/bin/zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd bash)"
fi

# fzf
if type -P /usr/bin/fzf &>/dev/null; then
    # Set up fzf key bindings and fuzzy completion
    eval "$(fzf --bash)"
fi

# autocd
shopt -s autocd

# upd (fedora/ubuntu)

if [ ! -f /etc/os-release ]; then
    echo "Warning: /etc/os-release not found"
    exit 0
fi

source /etc/os-release

case $ID in
'fedora')
    if type -P /usr/bin/dnf5 &>/dev/null; then
        alias dnf='dnf5'
    fi
    export -f upd_fedora
    alias upd='upd_fedora'
    ;;
'ubuntu')
    export -f upd_ubuntu
    alias upd='upd_ubuntu'
    ;;
*)
    echo "Warning: Distro not supported"
    ;;
esac
