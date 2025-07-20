# .
# VERSION 32

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

# from v4.0.1
# Abbreviations can now be restricted to specific commands. For instance:
# abbr --add --command git back 'reset --hard HEAD^'
# will expand `back` to `reset --hard HEAD^`, but only when the command is `git`

# ls options
#   -A, --almost-all: do not list implied . and ..
alias l 'ls -l'
alias la 'ls -lA'
alias lad 'ls -ld'
alias laa 'ls -la'
alias lag 'ls -lA --group-directories-first'
alias laz 'ls -laZ'
alias ladz 'ls -ladZ'
alias lazd 'ls -ladZ'
alias man 'man --nj'

if command -q ~/.local/bin/nvim
    alias vim '~/.local/bin/nvim'
end

alias fd 'fd --hidden --no-ignore --no-ignore-parent'
alias rg 'rg --no-line-number --hidden --no-ignore --no-ignore-parent'

abbr --add b btop
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
abbr --add r rg
abbr --add g rg
abbr --add t tree
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
abbr --add gls 'git log --show-signature'
abbr --add gp 'git push'
abbr --add gpl 'git pull'
abbr --add gr 'git remote -v'
abbr --add grs 'git reset'
abbr --add grs! 'git reset --hard'
abbr --add gs 'git status'
if command -q lazygit
    abbr --add lg lazygit
end

if command -q bat
    set bat_cmd bat
    # alias cat 'bat -pp' # no paging
    alias cat 'bat -p'
    abbr --add d batdiff
end

if command -q batcat
    set bat_cmd batcat
    alias bat batcat
    # alias cat 'batcat -pp' # no paging
    alias cat 'batcat -p'
    abbr --add d batdiff
end

abbr --add n npm
abbr --add nx npx

# npm via nvm, and plugin jorgebucaran/nvm.fish
if functions -q nvm
    nvm use latest 1>/dev/null
end

if command -q pnpm
    alias npx pnpx
    alias npm pnpm
    abbr --add n pnpm
    abbr --add nx pnpx
    abbr --add npm pnpm
    abbr --add npx pnpx
end

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
            echo "info: aicommits not present"
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
    set commit_message "…"
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
                # upd_npm_packages
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
                # upd_npm_packages
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
    if functions -q nvm
        if command -q pnpm
            echo -e '\e[1mUpdating npm -- user\e[0m'
            echo -e '\e[3mnvm use .., pnpm self-update, pnpm install -g npm@latest\e[0m\n'
            nvm use lts 1>/dev/null
            pnpm self-update 1>/dev/null
            pnpm install -g npm@latest 1>/dev/null
            echo "Node: $(nvm current) (lts)"
            echo "PNPM: $(pnpm --version)"
            echo
            nvm use latest 1>/dev/null
            pnpm self-update 1>/dev/null
            pnpm install -g npm@latest 1>/dev/null
            echo "Node: $(nvm current) (latest)"
            echo "PNPM: $(pnpm --version)"
            echo
        else
            echo -e '\e[1mUpdating npm -- user\e[0m'
            echo -e '\e[3mnvm use .., npm install -g npm@latest\e[0m\n'
            nvm use lts 1>/dev/null
            npm install -g npm@latest 1>/dev/null
            echo "Node: $(nvm current) (lts)"
            echo "NPM: $(npm --version)"
            echo
            nvm use latest 1>/dev/null
            npm install -g npm@latest 1>/dev/null
            echo "Node: $(nvm current) (latest)"
            echo "NPM: $(npm --version)"
            echo
        end
    end

    if not functions -q nvm; and command -q /usr/local/bin/npm
        echo -e '\e[1mUpdating npm\e[0m'
        echo -e '\e[3msudo npm install -g npm@latest\e[0m'
        sudo /usr/local/bin/npm install -g npm@latest
        echo
        echo "Node: $(node --version)"
        echo "NPM: $(/usr/local/bin/npm --version)"
        echo
    end
end

# function upd_npm -d 'npm update'
#     if command -q /usr/local/bin/npm
#         echo -e '\e[1mUpdating npm\e[0m'
#         echo -e '\e[3msudo npm install -g npm@latest\e[0m'
#         sudo /usr/local/bin/npm install -g npm@latest
#         echo
#         echo "NPM version: $(/usr/local/bin/npm --version)"
#         echo
#     end
#     if functions -q nvm
#         echo -e '\e[1mFor user, updating npm (lts)\e[0m'
#         echo -e '\e[3mnvm use lts, npm install -g npm@latest\e[0m\n'
#         nvm use lts
#         npm install -g npm@latest
#         echo
#         echo "NPM version: $(npm --version)"
#         echo
#         echo -e '\e[1mFor user, updating npm (latest)\e[0m'
#         echo -e '\e[3mnvm use latest, npm install -g npm@latest\e[0m\n'
#         nvm use latest
#         npm install -g npm@latest
#         echo
#         echo "NPM version: $(npm --version)"
#         echo
#     end
# end

# function upd_npm_packages -d 'npm update global packages'
#     if command -q /usr/local/bin/npm
#         echo -e '\e[1mUpdating npm packages\e[0m'
#         echo -e '\e[3msudo npm update\e[0m'
#         sudo /usr/local/bin/npm update
#         echo
#     end
# end

function upd_nvim_release -d 'nvim (release)'
    if command -q ~/.build/nvim/bin/nvim
        echo -e '\e[1mUpdating nvim (release)\e[0m'
        echo -e '\e[3mhttps://github.com/neovim/neovim\e[0m'
        echo

        for cmd in ninja-build cmake gcc make unzip gettext curl
            if not command -q $cmd
                echo "Error: '$cmd' not found"
                return 1
            end
        end

        # download json
        # set json (gh api /repos/neovim/neovim/releases/latest)
        set json (curl -sL https://api.github.com/repos/neovim/neovim/releases/latest)

        if test $status -ne 0
            echo "Error: Couldn't retrieve JSON response from 'https://api.github.com/repos/neovim/neovim/releases/latest'"
            return 1
        end

        set current_version (nvim --version | grep 'NVIM' | awk '{print $2}')
        set latest_version (echo $json | jq -r '.tag_name')

        set current_major (echo $current_version | sed 's/v//' | cut -d- -f1 | cut -d. -f1) # cut on -, if we have a pre-release version installed
        set current_minor (echo $current_version | sed 's/v//' | cut -d- -f1 | cut -d. -f2)
        set current_patch (echo $current_version | sed 's/v//' | cut -d- -f1 | cut -d. -f3)

        set latest_major (echo $latest_version | sed 's/v//' | cut -d- -f1 | cut -d. -f1)
        set latest_minor (echo $latest_version | sed 's/v//' | cut -d- -f1 | cut -d. -f2)
        set latest_patch (echo $latest_version | sed 's/v//' | cut -d- -f1 | cut -d. -f3)

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

        if test $need_update -eq 1
            echo "Update available: $current_version -> $latest_version"
            echo

            read -P "Do you want to update? [y/N]: " continue
            if test $continue != y -a $continue != Y
                return 0
            end
            echo

            set tarball_url (echo $json | jq -r '.tarball_url')

            if test -z "$tarball_url"
                echo "Error: Couldn't find the tarball URL in the JSON response"
                return 1
            end

            # "security check" aka https, github.com and repo neovim/neovim
            if not test (echo $tarball_url | cut -c1-42) = "https://api.github.com/repos/neovim/neovim"
                echo "Error: Unexpected tarball URL"
                echo "URL: $tarball_url"
                echo "Expected: https://api.github.com/repos/neovim/neovim ..."
                return 1
            end

            # temp file
            set temp_file (mktemp)

            # download tarball of latest release
            curl -sL -o $temp_file $tarball_url

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

            set build_dir ~/.build/neovim
            set install_dir ~/.build/nvim

            # backup
            if test -e $install_dir
                # while backup dir exists, keep adding -N
                set backup_dir ~/.build/nvim-working-$(date +%F)
                set backup_count 1
                while test -e $backup_dir
                    set backup_dir ~/.build/nvim-working-$(date +%F)-$backup_count
                    set backup_count (math $backup_count + 1)
                end

                mv $install_dir $backup_dir
                echo "Info: Backup available at $backup_dir"
                echo
            end

            # remove old build
            if test -e $build_dir
                rm -rf $build_dir
            end

            # extract
            mkdir -p $build_dir
            sudo tar -C $build_dir -xf $temp_file

            if test $status -ne 0
                echo "Error: Archive extraction failed"
                sudo rm -rf $build_dir
                rm $temp_file
                return 1
            end

            rm $temp_file

            # remember current CWD
            set user_cwd $PWD

            # build
            set build_dir (ls -d $build_dir/*) # get the extracted directory inside build_dir, something like neovim-neovim-xxxxxxx
            cd $build_dir
            make CMAKE_BUILD_TYPE=RelWithDebInfo
            if test $status -ne 0
                echo "Error: Couldn't build neovim"
                if test -n "$backup_dir"
                    echo "Info: Backup available at $backup_dir"
                end
                return 1
            end

            # install
            make install CMAKE_INSTALL_PREFIX=$install_dir

            # create symling in ~/.local/bin if it doesn't exist
            if not test -e ~/.local/bin/nvim
                mkdir -p ~/.local/bin
                ln -s $install_dir/bin/nvim ~/.local/bin/nvim
            end

            # restore CWD
            cd $user_cwd
        else
            echo "No update available"
        end

        echo
        echo "nvim version: $(nvim --version | grep 'NVIM' | awk '{print $2}')"
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
        # json=$(curl -s https://go.dev/dl/?mode=json)
        # json=$(wget -qO- https://go.dev/dl/?mode=json)
        set json (curl -s 'https://go.dev/dl/?mode=json')

        if test $status -ne 0
            echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
            return 1
        end

        set current_version (/usr/local/go/bin/go version | awk '{print $3}')
        set latest_version (echo $json | jq -r '.[0].version')

        set current_major (echo $current_version | sed 's/go//' | cut -d. -f1)
        set current_minor (echo $current_version | sed 's/go//' | cut -d. -f2)
        set current_patch (echo $current_version | sed 's/go//' | cut -d. -f3)

        set latest_major (echo $latest_version | sed 's/go//' | cut -d. -f1)
        set latest_minor (echo $latest_version | sed 's/go//' | cut -d. -f2)
        set latest_patch (echo $latest_version | sed 's/go//' | cut -d. -f3)

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

        set selected_json (echo $json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

        if test -n "$selected_json"
            set download_filename (echo $selected_json | jq -r '.filename')
            set download_checksum (echo $selected_json | jq -r '.sha256')
        else
            echo "Error: Couldn't find the latest version for $os-$arch in the JSON response"
            return 1
        end

        if test $need_update -eq 1
            echo "Update available: $current_version -> $latest_version"
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
            set temp_file (mktemp)

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
    # json=$(curl -s https://go.dev/dl/?mode=json)
    # json=$(wget -qO- https://go.dev/dl/?mode=json)
    set json (curl -s 'https://go.dev/dl/?mode=json')

    if test $status -ne 0
        echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
        return 1
    end

    set latest_version (echo $json | jq -r '.[0].version')
    set selected_json (echo $json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

    if test -n "$selected_json"
        set download_filename (echo $selected_json | jq -r '.filename')
        set download_checksum (echo $selected_json | jq -r '.sha256')
    else
        echo "Error: Couldn't find the latest version for $os-$arch in the JSON response"
        return 1
    end

    echo "Version available: $latest_version"
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
    set temp_file (mktemp)

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

function install_fzf -d 'Install fzf release'
    # echo -e '\e[1mInstalling fzf\e[0m'
    # echo -e '\e[3mhttps://github.com/junegunn/fzf\e[0m'
    # echo

    set repo junegunn/fzf

    set os (uname -s | tr '[:upper:]' '[:lower:]')
    set arch (uname -m)
    if test $arch = x86_64
        set arch amd64
    end
    set os_arch (string join _ $os $arch)

    # download json
    # set json (gh api /repos/neovim/neovim/releases/latest)
    set json (curl -sL https://api.github.com/repos/$repo/releases/latest)

    if test $status -ne 0
        echo "Error: Couldn't retrieve JSON response from 'https://api.github.com/repos/$repo/releases/latest'"
        return 1
    end

    set latest_release_tag (echo $json | jq -r '.tag_name')
    set latest_release (echo $json | jq -r '.name')
    set latest_major (echo $latest_release_tag | sed 's/v//' | cut -d- -f1 | cut -d. -f1)
    set latest_minor (echo $latest_release_tag | sed 's/v//' | cut -d- -f1 | cut -d. -f2)
    set latest_patch (echo $latest_release_tag | sed 's/v//' | cut -d- -f1 | cut -d. -f3)

    set archive_name "fzf-$latest_release-$os_arch.tar.gz"
    set selected_json (echo $json | jq -r --arg archive_name "$archive_name" '.assets[] | select(.name == $archive_name)')

    if test -n "$selected_json"
        set browser_download_url (echo $selected_json | jq -r '.browser_download_url')
    else
        echo "Error: Couldn't find the latest version for $os-$arch in the JSON response"
        return 1
    end

    # # temp file
    set temp_file (mktemp)

    # # download tarball of latest release
    curl -sL -o $temp_file $browser_download_url

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

    # remove old binary
    if test -e /usr/local/bin/fzf
        sudo rm -rf /usr/local/bin/fzf
    end

    # extract
    sudo tar -C /usr/local/bin -xf $temp_file

    if test $status -ne 0
        echo "Error: Archive extraction failed"
        sudo rm -rf /usr/local/bin/fzf
        rm $temp_file
        return 1
    end

    rm $temp_file

    echo
    echo "fzf version: $(fzf --version)"
    echo
end

function build_nvim_release -d 'nvim (release)'
    echo -e '\e[1mInstalling nvim (release)\e[0m'
    echo -e '\e[3mhttps://github.com/neovim/neovim\e[0m'
    echo

    for cmd in ninja cmake gcc make unzip gettext curl
        if not command -q $cmd
            echo "Error: '$cmd' not found"
            return 1
        end
    end

    set repo neovim/neovim

    set build_dir ~/.build/neovim
    set install_dir ~/.build/nvim

    # download json
    # set json (gh api /repos/neovim/neovim/releases/latest)
    set json (curl -sL https://api.github.com/repos/$repo/releases/latest)

    if test $status -ne 0
        echo "Error: Couldn't retrieve JSON response from 'https://api.github.com/repos/$repo/releases/latest'"
        return 1
    end

    set tarball_url (echo $json | jq -r '.tarball_url')

    if test -z "$tarball_url"
        echo "Error: Couldn't find the tarball URL in the JSON response"
        return 1
    end

    # "security check" aka https, github.com and same repo
    if not string match --quiet --regex "^https://api.github.com/repos/$repo/.*" $tarball_url
        echo "Error: Unexpected tarball URL"
        echo "URL:"
        echo "$tarball_url"
        echo "Expecpted:"
        echo "https://api.github.com/repos/$repo/ ..."
        return 1
    end

    # temp file
    set temp_file (mktemp)

    # download tarball of latest release
    curl -sL -o $temp_file $tarball_url

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

    # backup
    if test -e $install_dir
        # while backup dir exists, keep adding -N
        set backup_dir ~/.build/nvim-working-$(date +%F)
        set backup_count 1
        while test -e $backup_dir
            set backup_dir ~/.build/nvim-working-$(date +%F)-$backup_count
            set backup_count (math $backup_count + 1)
        end

        mv $install_dir $backup_dir
        echo "Info: Backup available at $backup_dir"
        echo
    end

    # remove old build
    if test -e $build_dir
        rm -rf $build_dir
    end

    # extract
    mkdir -p $build_dir
    tar -C $build_dir -xf $temp_file

    if test $status -ne 0
        echo "Error: Archive extraction failed"
        sudo rm -rf $build_dir
        rm $temp_file
        return 1
    end

    rm $temp_file

    # remember current CWD
    set user_cwd $PWD

    # build
    set build_dir (ls -d $build_dir/*) # get the extracted directory inside build_dir, something like neovim-neovim-xxxxxxx
    cd $build_dir
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    if test $status -ne 0
        echo "Error: Couldn't build neovim"
        if test -n "$backup_dir"
            echo "Info: Backup available at $backup_dir"
        end
        return 1
    end

    # install
    make install CMAKE_INSTALL_PREFIX=$install_dir

    # create symling in ~/.local/bin if it doesn't exist
    if not test -e ~/.local/bin/nvim
        mkdir -p ~/.local/bin
        ln -s $install_dir/bin/nvim ~/.local/bin/nvim
    end

    # restore CWD
    cd $user_cwd

    echo
    echo "nvim version: $(nvim --version | grep 'NVIM' | awk '{print $2}')"
    echo
end

# below not battle tested, for reference
# function upd_nvim_release_branch -d 'nvim (release branch, i.e release-0.11)'
#     if command -q ~/.build/nvim/bin/nvim
#         echo -e '\e[1mUpdating nvim\e[0m'
#         echo -e '\e[3mhttps://github.com/neovim/neovim\e[0m'
#         echo -e '\e[3mPrerequisites: ninja-build cmake gcc make unzip gettext curl glibc-gconv-extra\e[0m'
#         echo
#
#         for cmd in ninja-build cmake gcc make unzip gettext curl
#             if not command -q $cmd
#                 echo "Error: '$cmd' not found"
#                 return 1
#             end
#         end
#
#         # download json, get latest release tag
#         # set json (gh api /repos/neovim/neovim/releases/latest)
#         set json (curl -s -L https://api.github.com/repos/neovim/neovim/releases/latest)
#
#         if test $status -ne 0
#             echo "Error: Couldn't retrieve JSON response from 'https://api.github.com/repos/neovim/neovim/releases/latest'"
#             return 1
#         end
#
#         set latest_release_tag (echo $json | jq -r '.tag_name')
#         set latest_major (echo $latest_release_tag | sed 's/v//' | cut -d- -f1 | cut -d. -f1)
#         set latest_minor (echo $latest_release_tag | sed 's/v//' | cut -d- -f1 | cut -d. -f2)
#
#         # https://github.com/neovim/neovim/branches
#         set branch_name "release-$latest_major.$latest_minor"
#
#         set build_dir ~/.build/neovim
#         set install_dir ~/.build/nvim
#
#         # backup
#         if test -e $install_dir
#             # while backup dir exists, keep adding -N
#             set backup_dir ~/.build/nvim-working-$(date +%F)
#             set backup_count 1
#             while test -e $backup_dir
#                 set backup_dir ~/.build/nvim-working-$(date +%F)-$backup_count
#                 set backup_count (math $backup_count + 1)
#             end
#
#             mv $install_dir $backup_dir
#             echo "Info: Backup available at $backup_dir"
#             echo
#         end
#
#         # remove old build
#         if test -e $build_dir
#             rm -rf $build_dir
#         end
#
#         # clone
#         git clone https://github.com/neovim/neovim --depth 1 --branch $branch_name $build_dir
#         if test $status -ne 0
#             echo "Error: Couldn't clone neovim"
#             if test -n "$backup_dir"
#                 echo "Info: Backup available at $backup_dir"
#             end
#             return 1
#         end
#
#         # build
#         cd $build_dir
#         make CMAKE_BUILD_TYPE=RelWithDebInfo
#         if test $status -ne 0
#             echo "Error: Couldn't build neovim"
#             if test -n "$backup_dir"
#                 echo "Info: Backup available at $backup_dir"
#             end
#             return 1
#         end
#
#         # install
#         make install CMAKE_INSTALL_PREFIX=$install_dir
#
#         # create symling in ~/.local/bin if it doesn't exist
#         if not test -e ~/.local/bin/nvim
#             mkdir -p ~/.local/bin
#             ln -s $install_dir/bin/nvim ~/.local/bin/nvim
#         end
#
#         echo
#         echo "nvim version: $(nvim --version | grep 'NVIM' | awk '{print $2}')"
#         echo
#     end
# end

function build_nvim_nightly -d 'nvim (nightly)'
    echo -e '\e[1mInstalling nvim (nightly)\e[0m'
    echo -e '\e[3mhttps://github.com/neovim/neovim\e[0m'
    echo

    for cmd in ninja cmake gcc make unzip gettext curl
        if not command -q $cmd
            echo "Error: '$cmd' not found"
            return 1
        end
    end

    set build_dir ~/.build/neovim
    set install_dir ~/.build/nvim

    # backup
    if test -e $install_dir
        # while backup dir exists, keep adding -N
        set backup_dir ~/.build/nvim-working-$(date +%F)
        set backup_count 1
        while test -e $backup_dir
            set backup_dir ~/.build/nvim-working-$(date +%F)-$backup_count
            set backup_count (math $backup_count + 1)
        end

        mv $install_dir $backup_dir
        echo "Info: Backup available at $backup_dir"
        echo
    end

    # remove old build
    if test -e $build_dir
        rm -rf $build_dir
    end

    # clone
    git clone https://github.com/neovim/neovim --depth 1 $build_dir
    if test $status -ne 0
        echo "Error: Couldn't clone neovim"
        if test -n "$backup_dir"
            echo "Info: Backup available at $backup_dir"
        end
        return 1
    end

    # remember current CWD
    set user_cwd $PWD

    # build
    cd $build_dir
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    if test $status -ne 0
        echo "Error: Couldn't build neovim"
        if test -n "$backup_dir"
            echo "Info: Backup available at $backup_dir"
        end
        return 1
    end

    # install
    make install CMAKE_INSTALL_PREFIX=$install_dir

    # create symling in ~/.local/bin if it doesn't exist
    if not test -e ~/.local/bin/nvim
        mkdir -p ~/.local/bin
        ln -s $install_dir/bin/nvim ~/.local/bin/nvim
    end

    # restore CWD
    cd $user_cwd

    echo
    echo "nvim version: $(nvim --version | grep 'NVIM' | awk '{print $2}')"
    echo
end
