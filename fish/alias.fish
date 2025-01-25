# .
# VERSION 1.0.26

##
## Environment
##

# .
# .
# .
# .
# .

if test -z "$TMUX_DEFAULT_SESSION_NAME"
    set TMUX_DEFAULT_SESSION_NAME home
end

##
## Alias and Abbreviations
##

# ls options
#   -A, --almost-all: do not list implied . and ..
alias l 'ls -l'
alias la 'ls -lA'
alias ld 'ls -ld'
alias laa 'ls -la'
alias laz 'ls -laZ'
alias ladz 'ls -ladZ'
alias lazd 'ls -ladZ'
alias man 'man --nj'

if command -q ~/.local/bin/nvim
    alias vim '~/.local/bin/nvim'
end

alias fd 'fd --hidden --no-ignore --no-ignore-parent'
alias rg 'rg --no-line-number --hidden --no-ignore --no-ignore-parent'
alias wezterm 'flatpak run org.wezfurlong.wezterm'

if command -q btop
    abbr --add top btop
end

if command -q eza
    # Filtering options
    #   Pass the -a, --all option twice to also show the . and .. directories.
    # Long view options
    #   -a, --all: show hidden and 'dot' files
    #   -g, --group: list each file’s group
    #   --git: list each file’s Git status, if tracked or ignored
    alias ls 'eza -g --git'
    alias la 'eza -gla --git'
    alias ld 'eza -gld --git'
    alias laa 'eza -glaa --git'
    alias tree 'eza -aT --git-ignore'
end

if command -q pass
    abbr --add p 'pass show -c'
    abbr --add pe 'pass edit'
    abbr --add pf 'pass find'
    abbr --add pg 'pass generate -c -i'
    abbr --add pi 'pass insert -m'
end

# c<space> expands to cat, c<enter> behaves like an alias
abbr --add c cat
abbr --add f fd
abbr --add g rg
abbr --add t 'tree -D'
abbr --add v vim

# tmux
# https://github.com/lewisacidic/fish-tmux-abbr
abbr --add s "tmux attach || tmux new-session -s $TMUX_DEFAULT_SESSION_NAME"
abbr --add sn 'tmux new-session -A -s'
abbr --add sx 'tmux kill-session -t'
abbr --add sl 'tmux list-sessions'

# git
# https://github.com/lewisacidic/fish-git-abbr
abbr --add d 'git diff'
abbr --add ga 'git add'
abbr --add gc 'git commit -m'
abbr --add gcl 'git clone'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gf 'git fetch'
abbr --add gl 'git log'
abbr --add gp 'git push'
abbr --add gpl 'git pull'
abbr --add gr 'git remote -v'
abbr --add grs 'git reset'
abbr --add grs! 'git reset --hard'
abbr --add gs 'git status'
if type -q lazygit
    abbr --add lg lazygit
end

if command -q bat
    set bat_cmd bat
    alias cat 'bat -pp'
    abbr --add d batdiff
end

if command -q batcat
    set bat_cmd batcat
    alias cat 'batcat -pp'
    abbr --add d batdiff
end

abbr --add n npm

##
## Functions
##

# You like the output of batdiff for quick overview.
if test -n "$bat_cmd"
    function batdiff
        if not is_git_repo
            echo 'Error: Unable to locate a Git repository.'
            return 1
        end

        git diff --name-only --relative --diff-filter=d $argv | xargs $bat_cmd --diff
    end
end

# cdg (cd to git root directory)
function cdg -d 'cd to git root directory'
    if not is_git_repo
        echo 'Error: Unable to locate a Git repository.'
        return 1
    end

    set -l git_dir (git rev-parse --show-toplevel)
    if test -n "$git_dir"
        cd $git_dir
    end
end

# https://github.com/oh-my-fish/oh-my-fish/blob/master/lib/git/git_is_repo.fish
function is_git_repo -d 'Check if directory is a repository'
    test -d .git
    or begin
        set -l info (command git rev-parse --git-dir --is-bare-repository 2>/dev/null)
        and test $info[2] = false
    end
end

# gg (git add, git commit, git push)
# usage: gg [commit message]
function gg -d 'git add, git commit, git push'
    if not is_git_repo
        echo 'Error: Unable to locate a Git repository.'
        return 1
    end

    set use_ai 0

    if test (count $argv) -eq 0
        if command -q aicommits
            set use_ai 1
        else
            echo "Usage: gg [commit message]"
            echo "Info: aicommits not present"
            return 1
        end
    end

    if test $use_ai -eq 1
        # using aicomments
        # echo statements has bold text
        echo -e "\e[1mgit add -A\e[0m" && git add -A &&
            echo -e "\e[1maicommits\e[0m" && aicommits &&
            echo -e "\e[1mgit push\e[0m" && git push
    else
        # using user supplied commit message
        # echo statements has bold text
        echo -e "\e[1mgit add -A\e[0m" && git add -A &&
            echo -e "\e[1mgit commit -m \"$argv\"\e[0m" && git commit -m "$argv" &&
            echo -e "\e[1mgit push\e[0m" && git push
    end
end

# ww (git add, git commit, git push - whatthecommit.com)
# usage: ww
# like gg but random commit message from whatthecommit.com
function ww -d 'git add, git commit, git push - whatthecommit.com'
    if not is_git_repo
        echo 'Error: Unable to locate a Git repository.'
        return 1
    end

    if ! command -q curl
        echo "Error: Unable to locate 'curl'"
        return 1
    end

    set continue n
    while test "$continue" != y; and test "$continue" != Y
        set message (curl -s https://whatthecommit.com/index.txt)
        if test $status -ne 0
            echo "Error: Couldn't retrieve a commit message from 'whatthecommit.com'"
            return 1
        end

        echo "Commit message: $message"
        read -P "Do you want to use this commit message? [y/N/q]: " continue
        if test "$continue" = q
            return 0
        end
    end

    # echo statements has bold text
    echo -e "\e[1mgit add -A\e[0m" && git add -A &&
        echo -e "\e[1mgit commit -m \"$message\"\e[0m" && git commit -m "$message" &&
        echo -e "\e[1mgit push\e[0m" && git push
end

# wwd (Outputs whatthecommit.com commit messages)
# usage: wwd
function wwd -d 'Outputs whatthecommit.com commit messages'
    if ! command -q curl
        echo "Error: Unable to locate 'curl'"
        return 1
    end

    set continue n
    while test "$continue" != y; and test "$continue" != Y
        set message (curl -s https://whatthecommit.com/index.txt)
        if test $status -ne 0
            echo "Error: Couldn't retrieve a commit message from 'whatthecommit.com'"
            return 1
        end

        echo "Commit message: $message"
        read -P "Do you want to use this commit message? [y/N/q]: " continue
        if test "$continue" = q
            return 0
        end
    end
end

# git-tidy (Git History Cleanup)
# Usage: git-tidy [commit message]
abbr --add gt git-tidy
function git-tidy -d 'Git History Cleanup'
    if not is_git_repo
        echo 'Error: Unable to locate a Git repository.'
        return 1
    end

    read -P "Remove all Git history in this repo? [y/N]: " continue
    if test $continue != y -a $continue != Y
        return 0
    end

    # Create Backup
    echo -e '\n\n\e[1mCreate Backup\e[0m\n'

    set backup_dir (mktemp -d)
    if test $status -ne 0
        echo "Error: Couldn't create backup directory"
        return 1
    end

    git clone --mirror . $backup_dir
    if test $status -ne 0
        echo "Error: Couldn't create backup"
        rm -rf $backup_dir
        return 1
    end

    # Commit message
    set commit_message "Git History Cleanup"
    if test (count $argv) -gt 0
        set commit_message $argv
    end

    # Git History Cleanup
    echo -e '\n\n\e[1mGit History Cleanup\e[0m\n'
    git checkout --orphan latest_commit &&
        git add -A &&
        git commit -m "$commit_message" | grep -v " create mode " &&
        git branch -D main &&
        git branch -m main

    if test $status -ne 0
        echo "Error: Couldn't cleanup Git history"
        echo "Info: Backup available at $backup_dir"
        git checkout main
        git branch -D latest_commit
        return 1
    end
    echo "Info: Branch 'latest_commit' renamed to 'main'"

    # Push to Remote
    echo -e '\n\n\e[1mPush to Remote\e[0m\n'
    read -P "Push to remote? [Y/n]: " continue
    if test $continue = y -o $continue = Y -o $continue = ""
        git push -f --set-upstream origin main
    end

    # Remove Backup
    echo -e '\n\n\e[1mRemove Backup\e[0m\n'
    read -P "Remove backup? [Y/n]: " continue
    if test $continue = y -o $continue = Y -o $continue = ""
        echo "Info: Removing $backup_dir"
        rm -rf $backup_dir
    else
        echo "Info: Backup available at $backup_dir"
    end

    # Git Log
    echo -e '\n\n\e[1mNew Git Log\e[0m\n'
    git log
    echo
end

# upd (fedora/ubuntu)
if test -e /etc/os-release
    set os_id (grep -E "^ID=" /etc/os-release | cut -d= -f2)
    switch $os_id
        case fedora
            if command -q /usr/bin/dnf5
                alias dnf dnf5
            end

            function upd -d 'system update, flatpak apps update, fisher plugins update'
                echo -e '\e[1mUpdating system\e[0m'
                echo -e '\e[3msudo dnf upgrade\e[0m\n'
                sudo dnf upgrade -y
                echo
                if command -q /usr/bin/flatpak
                    echo -e '\e[1mUpdating flatpak apps\e[0m'
                    echo -e '\e[3mflatpak update\e[0m\n'
                    /usr/bin/flatpak update -y
                    echo
                end
                upd_fisher
                upd_gh_extensions
                upd_go
                upd_npm
                upd_npm_packages
            end
        case ubuntu
            function upd -d 'system update, snap apps update, fisher plugins update'
                if command -q /usr/bin/apt
                    echo -e '\e[1mUpdating system\e[0m'
                    echo -e '\e[3msudo apt update, sudo apt full-upgrade, sudo apt autoremove\e[0m\n'
                    sudo /usr/bin/apt update
                    sudo /usr/bin/apt full-upgrade -y
                    sudo /usr/bin/apt autoremove -y
                    echo
                end
                if command -q /usr/bin/snap
                    echo -e '\e[1mUpdating snap apps\e[0m'
                    echo -e '\e[3msudo snap refresh\e[0m\n'
                    sudo /usr/bin/snap refresh # requires sudo unless authenticated to an Ubuntu One/SSO account
                    echo
                end
                upd_fisher
                upd_gh_extensions
                upd_go
                upd_npm
                upd_npm_packages
            end
    end
end

function upd_fisher -d 'fisher update'
    if functions -q fisher
        echo -e '\e[1mUpdating fisher plugins\e[0m'
        echo -e '\e[3mfisher update\e[0m\n'
        fisher update 1>/dev/null
        # echo # above will not output anything unless there is an error
    end
end

function upd_gh_extensions -d 'Github CLI extensions update'
    if command -q gh
        echo -e '\e[1mUpdating Github CLI extensions\e[0m'
        echo -e '\e[3mgh extension upgrade --all\e[0m\n'
        gh extension upgrade --all
        echo
    end
end

function upd_npm -d 'npm update'
    if command -q /usr/local/bin/npm
        echo -e '\e[1mUpdating npm\e[0m'
        echo -e '\e[3msudo npm install -g npm@latest\e[0m'
        sudo /usr/local/bin/npm install -g npm@latest
        echo
        echo "NPM version: $(/usr/local/bin/npm --version)"
        echo
    end
    if functions -q nvm
        echo -e '\e[1mUpdating npm\e[0m'
        echo -e '\e[3mnvm use lts, npm install -g npm@latest\e[0m\n'
        nvm use lts
        npm install -g npm@latest
        echo
        echo "NPM version: $(npm --version)"
        echo
    end
end

function upd_npm_packages -d 'npm update global packages'
    if command -q /usr/local/bin/npm
        echo -e '\e[1mUpdating npm packages\e[0m'
        echo -e '\e[3msudo npm update\e[0m'
        sudo /usr/local/bin/npm update
        echo
    end
end

function upd_go -d 'golang update'
    # example download url: https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
    if command -q /usr/local/go/bin/go
        echo -e '\e[1mUpdating golang\e[0m'
        echo -e '\e[3mhttps://go.dev/dl\e[0m'
        echo

        for cmd in curl jq sha256sum tar
            if not command -q $cmd
                echo "Error: '$cmd' not found"
                return 1
            end
        end

        set os (uname -s | tr '[:upper:]' '[:lower:]')
        set arch (uname -m)
        if test $arch = x86_64
            set arch amd64
        end
        set kind archive
        set download_url_base 'https://go.dev/dl/'

        # download json
        # go_dev_json=$(curl -s https://go.dev/dl/?mode=json)
        # go_dev_json=$(wget -qO- https://go.dev/dl/?mode=json)
        set go_dev_json (curl -s 'https://go.dev/dl/?mode=json')

        if test $status -ne 0
            echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
            return 1
        end

        set current_go_version (/usr/local/go/bin/go version | awk '{print $3}')
        set latest_go_version (echo $go_dev_json | jq -r '.[0].version')

        set current_major (echo $current_go_version | sed 's/go//' | cut -d. -f1)
        set current_minor (echo $current_go_version | sed 's/go//' | cut -d. -f2)
        set current_patch (echo $current_go_version | sed 's/go//' | cut -d. -f3)

        set latest_major (echo $latest_go_version | sed 's/go//' | cut -d. -f1)
        set latest_minor (echo $latest_go_version | sed 's/go//' | cut -d. -f2)
        set latest_patch (echo $latest_go_version | sed 's/go//' | cut -d. -f3)

        set need_update 0
        if test $current_major -lt $latest_major
            set need_update 1
        else if test $current_major -eq $latest_major
            if test $current_minor -lt $latest_minor
                set need_update 1
            else if test $current_minor -eq $latest_minor
                if test $current_patch -lt $latest_patch
                    set need_update 1
                end
            end
        end

        set selected_json (echo $go_dev_json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_go_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

        if test -n "$selected_json"
            set download_filename (echo $selected_json | jq -r '.filename')
            set download_checksum (echo $selected_json | jq -r '.sha256')
        else
            echo "Error: Couldn't find the latest version for $os-$arch in the JSON response"
            return 1
        end

        if test $need_update -eq 1
            echo "Update available: $current_go_version -> $latest_go_version"
            echo

            # read -P "Do you want to update? [y/N]: " continue
            # if test $continue != "y" -a $continue != "Y"
            #   return 0
            # end
            # echo

            # check archive type based on filename
            switch $download_filename
                case '*.tar*'
                    set archive_type tar
                case '*'
                    echo "Error: Unknown archive type, expected a tar archive"
                    echo "Filename: $download_filename"
                    return 1
            end

            # temp file
            # Using sudo with no password to install to /usr/local/go, need consistent path
            # set temp_file (mktemp)
            set temp_file /tmp/tmp.golang_install

            # download go
            # curl -L -o "$temp_file $download_url_base$download_filename"
            # wget -q --show-progress -O "$temp_file $download_url_base$download_filename"
            curl -L -o $temp_file "$download_url_base$download_filename"

            if test $status -ne 0
                echo "Error: Download failed"
                if test -e $temp_file
                    rm $temp_file
                end
                return 1
            end

            if not test -e $temp_file
                echo "Error: Couldn't find the downloaded archive"
                return 1
            end

            # verify checksum
            set checksum (sha256sum $temp_file | cut -d' ' -f1)
            if test $checksum != $download_checksum
                echo "Error: Checksum verification failed"
                rm $temp_file
                return 1
            end

            # update
            sudo rm -rf /usr/local/go
            sudo tar -C /usr/local -xf $temp_file

            if test $status -ne 0
                echo "Error: Archive extraction failed"
                sudo rm -rf /usr/local/go
                rm $temp_file
                return 1
            end

            rm $temp_file
        else
            echo "No update available"
        end

        echo
        echo "Go version: $(/usr/local/go/bin/go version | awk '{print $3}')"
        echo
    end
end

function install_go -d 'golang install'
    # example download url: https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
    echo -e '\e[1mInstalling golang\e[0m'
    echo -e '\e[3mhttps://go.dev/dl\e[0m'
    echo

    for cmd in curl jq sha256sum tar
        if not command -q $cmd
            echo "Error: '$cmd' not found"
            return 1
        end
    end

    set os (uname -s | tr '[:upper:]' '[:lower:]')
    set arch (uname -m)
    if test $arch = x86_64
        set arch amd64
    end
    set kind archive
    set download_url_base 'https://go.dev/dl/'

    # download json
    # go_dev_json=$(curl -s https://go.dev/dl/?mode=json)
    # go_dev_json=$(wget -qO- https://go.dev/dl/?mode=json)
    set go_dev_json (curl -s 'https://go.dev/dl/?mode=json')

    if test $status -ne 0
        echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
        return 1
    end

    set latest_go_version (echo $go_dev_json | jq -r '.[0].version')
    set selected_json (echo $go_dev_json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_go_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

    if test -n "$selected_json"
        set download_filename (echo $selected_json | jq -r '.filename')
        set download_checksum (echo $selected_json | jq -r '.sha256')
    else
        echo "Error: Couldn't find the latest version for $os-$arch in the JSON response"
        return 1
    end

    echo "Version available: $latest_go_version"
    echo

    read -P "Do you want to install Go? [y/N]: " continue
    if test $continue != y -a $continue != Y
        return 0
    end
    echo

    # check archive type based on filename
    switch $download_filename
        case '*.tar*'
            set archive_type tar
        case '*'
            echo "Error: Unknown archive type, expected a tar archive"
            echo "Filename: $download_filename"
            return 1
    end

    # temp file
    # Using sudo with no password to install to /usr/local/go, need consistent path
    # set temp_file (mktemp)
    set temp_file /tmp/tmp.golang_install

    # download go
    # curl -L -o "$temp_file $download_url_base$download_filename"
    # wget -q --show-progress -O "$temp_file $download_url_base$download_filename"
    curl -L -o $temp_file "$download_url_base$download_filename"

    if test $status -ne 0
        echo "Error: Download failed"
        if test -e $temp_file
            rm $temp_file
        end
        return 1
    end

    if not test -e $temp_file
        echo "Error: Couldn't find the downloaded archive"
        return 1
    end

    # verify checksum
    set checksum (sha256sum $temp_file | cut -d' ' -f1)
    if test $checksum != $download_checksum
        echo "Error: Checksum verification failed"
        rm $temp_file
        return 1
    end

    # install
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xf $temp_file

    if test $status -ne 0
        echo "Error: Archive extraction failed"
        sudo rm -rf /usr/local/go
        rm $temp_file
        return 1
    end

    rm $temp_file

    echo
    echo "Go version: $(/usr/local/go/bin/go version | awk '{print $3}')"
    echo
end

function upd_bashrc -d 'update bashrc'
    echo -e '\e[1mUpdating ~/.bashrc\e[0m\n'

    if not test -e ~/.dotfiles/.bashrc
        echo "Error: Couldn't find ~/.dotfiles/.bashrc"
        return 1
    end

    # create backup
    if test -e ~/.bashrc
        cp ~/.bashrc ~/.bashrc.bak
    end

    # remove current additions
    sed -i '/# default distro ~\/.bashrc above/,$ d' ~/.bashrc
    if test $status -ne 0
        echo "Error: Couldn't clean ~/.bashrc from current additions."
        mv ~/.bashrc.bak ~/.bashrc
        return 1
    end

    # add new additions
    cat ~/.dotfiles/.bashrc >>~/.bashrc
    if test $status -ne 0
        echo "Error: Couldn't update ~/.bashrc"
        mv ~/.bashrc.bak ~/.bashrc
        return 1
    end

    # no source, we are in fish
    # source ~/.bashrc

    rm -f ~/.bashrc.bak

    echo "Version: $(grep -E "^# VERSION" ~/.bashrc | cut -d' ' -f3)"
end

# gitleaks
# `gitleaks complesion fish`
# fish completion for gitleaks                             -*- shell-script -*-
function __gitleaks_debug
    set -l file "$BASH_COMP_DEBUG_FILE"
    if test -n "$file"
        echo "$argv" >>$file
    end
end

function __gitleaks_perform_completion
    __gitleaks_debug "Starting __gitleaks_perform_completion"

    # Extract all args except the last one
    set -l args (commandline -opc)
    # Extract the last arg and escape it in case it is a space
    set -l lastArg (string escape -- (commandline -ct))

    __gitleaks_debug "args: $args"
    __gitleaks_debug "last arg: $lastArg"

    # Disable ActiveHelp which is not supported for fish shell
    set -l requestComp "GITLEAKS_ACTIVE_HELP=0 $args[1] __complete $args[2..-1] $lastArg"

    __gitleaks_debug "Calling $requestComp"
    set -l results (eval $requestComp 2> /dev/null)

    # Some programs may output extra empty lines after the directive.
    # Let's ignore them or else it will break completion.
    # Ref: https://github.com/spf13/cobra/issues/1279
    for line in $results[-1..1]
        if test (string trim -- $line) = ""
            # Found an empty line, remove it
            set results $results[1..-2]
        else
            # Found non-empty line, we have our proper output
            break
        end
    end

    set -l comps $results[1..-2]
    set -l directiveLine $results[-1]

    # For Fish, when completing a flag with an = (e.g., <program> -n=<TAB>)
    # completions must be prefixed with the flag
    set -l flagPrefix (string match -r -- '-.*=' "$lastArg")

    __gitleaks_debug "Comps: $comps"
    __gitleaks_debug "DirectiveLine: $directiveLine"
    __gitleaks_debug "flagPrefix: $flagPrefix"

    for comp in $comps
        printf "%s%s\n" "$flagPrefix" "$comp"
    end

    printf "%s\n" "$directiveLine"
end

# this function limits calls to __gitleaks_perform_completion, by caching the result behind $__gitleaks_perform_completion_once_result
function __gitleaks_perform_completion_once
    __gitleaks_debug "Starting __gitleaks_perform_completion_once"

    if test -n "$__gitleaks_perform_completion_once_result"
        __gitleaks_debug "Seems like a valid result already exists, skipping __gitleaks_perform_completion"
        return 0
    end

    set --global __gitleaks_perform_completion_once_result (__gitleaks_perform_completion)
    if test -z "$__gitleaks_perform_completion_once_result"
        __gitleaks_debug "No completions, probably due to a failure"
        return 1
    end

    __gitleaks_debug "Performed completions and set __gitleaks_perform_completion_once_result"
    return 0
end

# this function is used to clear the $__gitleaks_perform_completion_once_result variable after completions are run
function __gitleaks_clear_perform_completion_once_result
    __gitleaks_debug ""
    __gitleaks_debug "========= clearing previously set __gitleaks_perform_completion_once_result variable =========="
    set --erase __gitleaks_perform_completion_once_result
    __gitleaks_debug "Successfully erased the variable __gitleaks_perform_completion_once_result"
end

function __gitleaks_requires_order_preservation
    __gitleaks_debug ""
    __gitleaks_debug "========= checking if order preservation is required =========="

    __gitleaks_perform_completion_once
    if test -z "$__gitleaks_perform_completion_once_result"
        __gitleaks_debug "Error determining if order preservation is required"
        return 1
    end

    set -l directive (string sub --start 2 $__gitleaks_perform_completion_once_result[-1])
    __gitleaks_debug "Directive is: $directive"

    set -l shellCompDirectiveKeepOrder 32
    set -l keeporder (math (math --scale 0 $directive / $shellCompDirectiveKeepOrder) % 2)
    __gitleaks_debug "Keeporder is: $keeporder"

    if test $keeporder -ne 0
        __gitleaks_debug "This does require order preservation"
        return 0
    end

    __gitleaks_debug "This doesn't require order preservation"
    return 1
end


# This function does two things:
# - Obtain the completions and store them in the global __gitleaks_comp_results
# - Return false if file completion should be performed
function __gitleaks_prepare_completions
    __gitleaks_debug ""
    __gitleaks_debug "========= starting completion logic =========="

    # Start fresh
    set --erase __gitleaks_comp_results

    __gitleaks_perform_completion_once
    __gitleaks_debug "Completion results: $__gitleaks_perform_completion_once_result"

    if test -z "$__gitleaks_perform_completion_once_result"
        __gitleaks_debug "No completion, probably due to a failure"
        # Might as well do file completion, in case it helps
        return 1
    end

    set -l directive (string sub --start 2 $__gitleaks_perform_completion_once_result[-1])
    set --global __gitleaks_comp_results $__gitleaks_perform_completion_once_result[1..-2]

    __gitleaks_debug "Completions are: $__gitleaks_comp_results"
    __gitleaks_debug "Directive is: $directive"

    set -l shellCompDirectiveError 1
    set -l shellCompDirectiveNoSpace 2
    set -l shellCompDirectiveNoFileComp 4
    set -l shellCompDirectiveFilterFileExt 8
    set -l shellCompDirectiveFilterDirs 16

    if test -z "$directive"
        set directive 0
    end

    set -l compErr (math (math --scale 0 $directive / $shellCompDirectiveError) % 2)
    if test $compErr -eq 1
        __gitleaks_debug "Received error directive: aborting."
        # Might as well do file completion, in case it helps
        return 1
    end

    set -l filefilter (math (math --scale 0 $directive / $shellCompDirectiveFilterFileExt) % 2)
    set -l dirfilter (math (math --scale 0 $directive / $shellCompDirectiveFilterDirs) % 2)
    if test $filefilter -eq 1; or test $dirfilter -eq 1
        __gitleaks_debug "File extension filtering or directory filtering not supported"
        # Do full file completion instead
        return 1
    end

    set -l nospace (math (math --scale 0 $directive / $shellCompDirectiveNoSpace) % 2)
    set -l nofiles (math (math --scale 0 $directive / $shellCompDirectiveNoFileComp) % 2)

    __gitleaks_debug "nospace: $nospace, nofiles: $nofiles"

    # If we want to prevent a space, or if file completion is NOT disabled,
    # we need to count the number of valid completions.
    # To do so, we will filter on prefix as the completions we have received
    # may not already be filtered so as to allow fish to match on different
    # criteria than the prefix.
    if test $nospace -ne 0; or test $nofiles -eq 0
        set -l prefix (commandline -t | string escape --style=regex)
        __gitleaks_debug "prefix: $prefix"

        set -l completions (string match -r -- "^$prefix.*" $__gitleaks_comp_results)
        set --global __gitleaks_comp_results $completions
        __gitleaks_debug "Filtered completions are: $__gitleaks_comp_results"

        # Important not to quote the variable for count to work
        set -l numComps (count $__gitleaks_comp_results)
        __gitleaks_debug "numComps: $numComps"

        if test $numComps -eq 1; and test $nospace -ne 0
            # We must first split on \t to get rid of the descriptions to be
            # able to check what the actual completion will be.
            # We don't need descriptions anyway since there is only a single
            # real completion which the shell will expand immediately.
            set -l split (string split --max 1 \t $__gitleaks_comp_results[1])

            # Fish won't add a space if the completion ends with any
            # of the following characters: @=/:.,
            set -l lastChar (string sub -s -1 -- $split)
            if not string match -r -q "[@=/:.,]" -- "$lastChar"
                # In other cases, to support the "nospace" directive we trick the shell
                # by outputting an extra, longer completion.
                __gitleaks_debug "Adding second completion to perform nospace directive"
                set --global __gitleaks_comp_results $split[1] $split[1].
                __gitleaks_debug "Completions are now: $__gitleaks_comp_results"
            end
        end

        if test $numComps -eq 0; and test $nofiles -eq 0
            # To be consistent with bash and zsh, we only trigger file
            # completion when there are no other completions
            __gitleaks_debug "Requesting file completion"
            return 1
        end
    end

    return 0
end

# Since Fish completions are only loaded once the user triggers them, we trigger them ourselves
# so we can properly delete any completions provided by another script.
# Only do this if the program can be found, or else fish may print some errors; besides,
# the existing completions will only be loaded if the program can be found.
if type -q gitleaks
    # The space after the program name is essential to trigger completion for the program
    # and not completion of the program name itself.
    # Also, we use '> /dev/null 2>&1' since '&>' is not supported in older versions of fish.
    complete --do-complete "gitleaks " >/dev/null 2>&1
end

# Remove any pre-existing completions for the program since we will be handling all of them.
complete -c gitleaks -e

# this will get called after the two calls below and clear the $__gitleaks_perform_completion_once_result global
complete -c gitleaks -n __gitleaks_clear_perform_completion_once_result
# The call to __gitleaks_prepare_completions will setup __gitleaks_comp_results
# which provides the program's completion choices.
# If this doesn't require order preservation, we don't use the -k flag
complete -c gitleaks -n 'not __gitleaks_requires_order_preservation && __gitleaks_prepare_completions' -f -a '$__gitleaks_comp_results'
# otherwise we use the -k flag
complete -k -c gitleaks -n '__gitleaks_requires_order_preservation && __gitleaks_prepare_completions' -f -a '$__gitleaks_comp_results'
