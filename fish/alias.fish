#
# alias.fish

# @fish-lsp-disable 2002 4004
#   2002    alias used, prefer using functions instead [2002]
#   4004    Unused local function [4004]

##
## Alias and Abbreviations
##

# from v4.0.1
# Abbreviations can now be restricted to specific commands. For instance:
# abbr --add --command git back 'reset --hard HEAD^'
# will expand `back` to `reset --hard HEAD^`, but only when the command is `git`

# ls options
#   -A, --almost-all: do not list implied . and ..
alias l ls
alias ll 'ls -l'
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
    # alias eza 'eza --icons'
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
    abbr --add po 'pass otp -c'

    function pu -d 'pass username'
        if test (count $argv) -ne 1
            echo "Usage: pu <entry>" >&2
            return 1
        end

        set entry $argv[1]

        # set username (pass show "$entry" | awk -F': *' 'BEGIN{IGNORECASE=1} /^\s*username:/ {print $2}' | xargs)
        set username (pass show "$entry" | grep -i '^\s*username:' | cut -d':' -f2 | xargs)
        if test -n "$username"
            set -q PASSWORD_STORE_CLIP_TIME; or set PASSWORD_STORE_CLIP_TIME 45
            set old_clip (wl-paste)

            echo -n "$username" | wl-copy

            fish -c "
                sleep $PASSWORD_STORE_CLIP_TIME
                set current_clip (wl-paste)
                if test \"\$current_clip\" = \"$username\"
                    echo -n \"$old_clip\" | wl-copy
                end
            " &
            echo "Username copied to clipboard. Will clear in $PASSWORD_STORE_CLIP_TIME seconds."
        else
            echo "Error: Username not found for '$entry'."
            return 1
        end
    end
end

# c<space> expands to cat, c<enter> behaves like an alias
abbr --add c cat
abbr --add f fd
abbr --add g rg
abbr --add t 'tree -L 3'
abbr --add td 'tree -D -L 3'
abbr --add v vim
abbr --add vo 'NVIM_APPNAME=nvim-prev vim' # old
abbr --add vn 'NVIM_APPNAME=nvim-test vim' # new
abbr --add sha sha256sum
abbr --add sshk "ssh -F /dev/null -o IdentitiesOnly=yes -i ~/.ssh/"

# tmux
# https://github.com/lewisacidic/fish-tmux-abbr
# abbr --add s "tmux attach || tmux new-session -s $TMUX_DEFAULT_SESSION_NAME"
# abbr --add sn 'tmux new-session -A -s'
# abbr --add sx 'tmux kill-session -t'
# abbr --add sl 'tmux list-sessions'

# git
# https://github.com/lewisacidic/fish-git-abbr
abbr --add d 'git diff'
abbr --add ga 'git add'
abbr --add gb 'git branch'
abbr --add gc 'git commit -m'
abbr --add gcl 'git clone'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gdc 'git diff origin/main -- path/to/file' # Compare committed history (your branch vs origin/main)
abbr --add gds 'git diff --cached origin/main -- path/to/file' # Compare staged changes only (index vs origin/main)
abbr --add gdw 'git diff origin/main -- path/to/file' # Compare working tree (everything, committed + staged + unstaged) vs origin/main
abbr --add gf 'git fetch'
abbr --add gl 'git log --pretty=oneline --graph --decorate --abbrev-commit'
abbr --add gls 'git log --show-signature'
abbr --add gp 'git push'
abbr --add gpl 'git pull'
abbr --add gr 'git remote -v'
abbr --add grl 'git reflog'
abbr --add grs 'git reset'
abbr --add grs! 'git reset --hard'
abbr --add gs 'git status'
if command -q gitleaks
    abbr --add glp gitleaks git --verbose --pre-commit --staged
end
if command -q lazygit
    abbr --add lg lazygit
end

if command -q bat
    set bat_cmd bat
    # alias cat 'bat -pp' # no paging
    alias cat 'bat -p'
    abbr --add d batdiff
    abbr --add bd batdiff
end

if command -q batcat
    set bat_cmd batcat
    alias bat batcat
    # alias cat 'batcat -pp' # no paging
    alias cat 'batcat -p'
    abbr --add d batdiff
    abbr --add bd batdiff
end

if command -q difft
    abbr --add d 'git -c diff.external=difft diff'
    abbr --add ds 'git -c diff.external=difft diff --staged'
end

if set -q WEZTERM_EXECUTABLE; and command -v rsvg-convert >/dev/null 2>&1
    function ci
        if test (count $argv) -ne 1
            echo "Usage: ci <image-file>" >&2
            return 1
        end

        set image_file $argv[1]

        if not test -f $image_file
            echo "Error: File '$image_file' not found" >&2
            return 1
        end

        if string match -q '*.svg' $image_file
            rsvg-convert $image_file | wezterm imgcat
            return $status
        else
            wezterm imgcat $image_file
        end
    end
else if set -q WEZTERM_EXECUTABLE
    abbr --add ci "wezterm imgcat"
end

abbr --add n npm
abbr --add x npx

if command -q pnpm
    alias npm pnpm
    alias npx pnpm
    abbr --add n pnpm
    abbr --add x pnpm
    abbr --add npm pnpm
    abbr --add npx pnpm
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

# if command -q difft
#     function difftastic
#         if not is_git_repo
#             echo 'Error: Unable to locate a Git repository.'
#             return 1
#         end
#
#         git -c diff.external=difft diff $argv
#     end
# end

function is_git_repo
    git rev-parse --is-inside-work-tree &>/dev/null
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

# gg (git add, git commit, git push)
# usage: gg [commit message]
function gg -d 'git add, git commit, git push'
    if not is_git_repo
        echo 'Error: Unable to locate a Git repository.'
        return 1
    end

    set use_ai 0

    if test (count $argv) -eq 0
        if functions -q aicommit
            set use_ai 1
        else
            echo "Usage: gg [commit message]"
            echo "Info: Didn't find aicommit."
            return 1
        end
    end

    if test $use_ai -eq 1
        # using aicommit
        # echo statements has bold text
        echo -e "\e[1mgit add -A\e[0m" && git add -A &&
            echo -e "\e[1maicommit\e[0m" && aicommit &&
            echo -e "\e[1mgit push\e[0m" && git push
    else
        # using user supplied commit message
        # echo statements has bold text
        echo -e "\e[1mgit add -A\e[0m" && git add -A &&
            echo -e "\e[1mgit commit -m \"$argv\"\e[0m" && git commit -m "$argv" &&
            echo -e "\e[1mgit push\e[0m" && git push
    end
end

function aicommit -d 'Generate commit message using AI'
    if not is_git_repo
        echo 'Error: Unable to locate a Git repository.'
        return 1
    end

    if not command -q openai
        echo "Error: 'openai' not found."
        return 1
    end

    if git diff --cached --quiet
        echo "No staged changes found."
        return 1
    end

    set continue n
    # -g user "Write a concise commit message for the following git diff:" \
    while test "$continue" != y; and test "$continue" != Y
        set message (openai api chat.completions.create \
        -m gpt-5-mini \
        -g user "Write a very short commit message for the following git diff:" \
        -g user "$(git diff --cached)")
        if test $status -ne 0
            echo "Error: Couldn't retrieve a commit message from 'openai'"
            return 1
        end

        echo
        echo "$message"
        read -P "Use this commit message? [y/N/q]: " continue
        if test "$continue" = q
            return 1
        end
    end

    git commit -m "$message"
end

# gg (git add, git commit, git push)
# usage: gg [commit message]
# function gg -d 'git add, git commit, git push'
#     if not is_git_repo
#         echo 'Error: Unable to locate a Git repository.'
#         return 1
#     end
#
#     set use_ai 0
#
#     if test (count $argv) -eq 0
#         if command -q aicommits
#             set use_ai 1
#         else
#             echo "Usage: gg [commit message]"
#             echo "info: aicommits not present"
#             return 1
#         end
#     end
#
#     if test $use_ai -eq 1
#         # using aicomments
#         # echo statements has bold text
#         echo -e "\e[1mgit add -A\e[0m" && git add -A &&
#             echo -e "\e[1maicommits\e[0m" && aicommits &&
#             echo -e "\e[1mgit push\e[0m" && git push
#     else
#         # using user supplied commit message
#         # echo statements has bold text
#         echo -e "\e[1mgit add -A\e[0m" && git add -A &&
#             echo -e "\e[1mgit commit -m \"$argv\"\e[0m" && git commit -m "$argv" &&
#             echo -e "\e[1mgit push\e[0m" && git push
#     end
# end

# ww (git add, git commit, git push - whatthecommit.com)
# usage: ww
# like gg but random commit message from whatthecommit.com
function ww -d 'git add, git commit, git push - whatthecommit.com'
    if not is_git_repo
        echo 'Error: Unable to locate a Git repository.'
        return 1
    end

    if command -q wwd.py
        set cmd wwd.py
        set src l
    else if command -q curl
        set cmd 'curl -s https://whatthecommit.com/index.txt'
        set src r
    else
        echo "Error: Unable to locate 'wwd.py' or 'curl'"
        return 1
    end

    set favorites $XDG_DATA_HOME/ww/favorites

    set continue n
    while test "$continue" != y; and test "$continue" != Y
        set message ($cmd)
        if test $status -ne 0
            echo "$cmd"
            echo "Error: Couldn't retrieve a commit message"
            return 1
        end

        echo "$message"
        read -P "Use commit message? ($src) [y/N/f/q]: " continue
        if test "$continue" = q
            return 0
        else if test "$continue" = f
            mkdir -p $XDG_DATA_HOME/wwd
            echo "$message" >>$favorites

            echo
            echo -e "\e[1mSaved as favorite\e[0m"
            echo "Use 'wwf' to see the favorites."
            break
        end
        echo
    end

    # echo statements has bold text
    echo -e "\e[1mgit add -A\e[0m" && git add -A &&
        echo -e "\e[1mgit commit -m \"$message\"\e[0m" && git commit -m "$message" &&
        echo -e "\e[1mgit push\e[0m" && git push
end

# wwd (commit messages from whatthecommit.com)
# usage: wwd
function wwd -d 'Commit messages from whatthecommit.com'
    if not command -q wwd.py
        echo "Error: Unable to locate 'wwd.py'"
        return 1
    end

    set cmd wwd.py
    set favorites $XDG_DATA_HOME/ww/favorites

    set continue n
    while test "$continue" != y; and test "$continue" != Y
        set message ($cmd)
        if test $status -ne 0
            echo "Error: Couldn't retrieve a commit message"
            return 1
        end

        echo "$message"
        read -P "Copy message? [y/N/f/q]: " continue
        if test "$continue" = q
            return 0
        else if test "$continue" = f
            mkdir -p $XDG_DATA_HOME/wwd
            echo "$message" >>$favorites

            echo
            echo -e "\e[1mSaved as favorite\e[0m"
            echo "Use 'wwf' to see the favorites."
            break
        end
        echo
    end

    echo "$message"
    echo -n "$message" | wl-copy
end

# wwf (favorite commit messages from whatthecommit.com)
# usage: wwf
function wwf -d 'Favorite commit messages from whatthecommit.com'
    set favorites $XDG_DATA_HOME/ww/favorites

    if not test -e $favorites
        echo "Error: No favorites found. Use 'wwd' to add favorites."
        return 1
    end

    set message (shuf $favorites | head -n 1)
    if test -z "$message"
        echo "Error: No favorites found"
        return 1
    end

    echo "$message"
    echo -n "$message" | wl-copy
end

# Old, for reference
# wwd (commit messages from whatthecommit.com)
# usage: wwd
# function wwd -d 'Commit messages from whatthecommit.com'
#     if command -q wwd.py
#         set cmd wwd.py
#         set src l
#     else if command -q curl
#         set cmd 'curl -s https://whatthecommit.com/index.txt'
#         set src r
#     else
#         echo "Error: Unable to locate 'wwd.py' or 'curl'"
#         return 1
#     end
#
#     set favorites $XDG_DATA_HOME/ww/favorites
#
#     set continue n
#     while test "$continue" != y; and test "$continue" != Y
#         set message ($cmd)
#         if test $status -ne 0
#             echo "$cmd"
#             echo "Error: Couldn't retrieve a commit message"
#             return 1
#         end
#
#         echo "$message"
#         read -P "Copy? $src [y/N/f/q]: " continue
#         if test "$continue" = q
#             return 0
#         else if test "$continue" = f
#             mkdir -p $XDG_DATA_HOME/wwd
#             echo "$message" >>$favorites
#
#             echo
#             echo -e "\e[1mSaved as favorite\e[0m"
#             echo "Use 'wwf' to see the favorites."
#             break
#         end
#         echo
#     end
#
#     echo -e "\e[1mCopied to clipboard\e[0m"
#     echo "$message"
#     echo -n "$message" | wl-copy
# end

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
    set -l backup_dir (mktemp -d)
    if test $status -ne 0
        echo "Error: Couldn't create backup directory"
        return 1
    end

    set -l git_dir (git rev-parse --show-toplevel)
    if test $status -ne 0
        echo "Error: Unable to locate Git root directory"
        rm -rf $backup_dir
        return 1
    end
    echo "Info: Git root directory: $git_dir"
    echo "Info: Backup directory: $backup_dir"

    if not cp -a $git_dir $backup_dir
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

    # Git Reflog Cleanup
    echo -e '\n\n\e[1mClean Reflog\e[0m\n'
    read -P "Clean reflog? [y/N]: " continue
    if test $continue = y -o $continue = Y
        git reflog expire --expire=all --expire-unreachable=all --all &&
            git gc --prune=now
    else
        echo "Commands to clean reflog:"
        echo "    git reflog expire --expire=all --expire-unreachable=all --all"
        echo "    git gc --prune=now"
    end
end

# upd (fedora/ubuntu)
if test -e /etc/os-release
    set os_id (grep -E "^ID=" /etc/os-release | cut -d= -f2)
    switch $os_id
        case fedora
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
    if command -q nvm
        if command -q pnpm
            echo -e '\e[1mUpdating npm -- user\e[0m'
            echo -e '\e[3mnvm install.., nvm use.., pnpm self-update\e[0m\n'
            pnpm self-update 1>/dev/null
            nvm install lts 1>/dev/null
            nvm use lts 1>/dev/null
            # pnpm install -g npm@latest 1>/dev/null
            echo "Node: $(nvm current) (lts)"
            echo "PNPM: $(pnpm --version)"
            echo
            nvm install latest 1>/dev/null
            nvm use latest 1>/dev/null
            # pnpm install -g npm@latest 1>/dev/null
            echo "node: $(nvm current) (latest)"
            echo "pnpm: $(pnpm --version)"
            echo
        else
            echo -e '\e[1mUpdating npm -- user\e[0m'
            echo -e '\e[3mnvm install.., nvm use..\e[0m\n'
            nvm install lts 1>/dev/null
            nvm use lts 1>/dev/null
            # npm install -g npm@latest 1>/dev/null
            echo "node: $(nvm current) (lts)"
            echo "npm: $(npm --version)"
            echo
            nvm install latest 1>/dev/null
            nvm use latest 1>/dev/null
            # npm install -g npm@latest 1>/dev/null
            echo "node: $(nvm current) (latest)"
            echo "npm: $(npm --version)"
            echo
        end
    end

    if not command -q nvm; and command -q /usr/local/bin/npm
        echo -e '\e[1mUpdating npm\e[0m'
        echo -e '\e[3msudo npm install -g npm@latest\e[0m'
        sudo /usr/local/bin/npm install -g npm@latest
        echo
        echo "Node: $(node --version)"
        echo "NPM: $(/usr/local/bin/npm --version)"
        echo
    end
end

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

function init_shell_completion -d 'create shell completion files in ~/.config/fish/completions'
    mkdir -p $XDG_CONFIG_HOME/fish/completions

    # bat
    if command -q bat
        bat --completion fish >"$XDG_CONFIG_HOME/fish/completions/bat.fish"
    end

    # batcat
    if command -q batcat
        batcat --completion fish >"$XDG_CONFIG_HOME/fish/completions/batcat.fish"
    end

    # fnm
    # if command -q fnm
    #     fnm completions --shell fish >"$XDG_CONFIG_HOME/fish/completions/fnm.fish"
    # end

    # fzf
    if command -q fzf
        # https://github.com/junegunn/fzf#setting-up-shell-integration
        # https://github.com/junegunn/fzf#key-bindings-for-command-line
        fzf --fish >~/.config/fish/completions/fzf.fish
    end

    # github cli
    if command -q gh
        # gh completion -s fish | source
        gh completion -s fish >~/.config/fish/completions/gh.fish
    end

    # gitleaks
    if command -q gitleaks
        # gitleaks completion fish | source
        gitleaks completion fish >~/.config/fish/completions/gitleaks.fish
    end

    # wezterm
    if command -q wezterm
        # wezterm shell-completion --shell fish | source
        wezterm shell-completion --shell fish >~/.config/fish/completions/wezterm.fish
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
