#
# .zshrc

# shellcheck disable=all

# XDG Base Directory, User Directories
export XDG_CONFIG_HOME="$HOME/.config"     # User-specific configurations, analogous to /etc
export XDG_CACHE_HOME="$HOME/.cache"       # User-specific non-essential (cached) data, analogous to /var/cache
export XDG_DATA_HOME="$HOME/.local/share"  # User-specific data files, analogous to /usr/share
export XDG_STATE_HOME="$HOME/.local/state" # User-specific state files, analogous to /var/lib

# Prompt
prompt_git_info() {
    local branch git_status staged_count modified_count untracked_count

    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return 0

    git_status=$(git status --porcelain 2>/dev/null)
    staged_count=$(echo "$git_status" | grep -c '^[AMRD]')
    modified_count=$(echo "$git_status" | grep -c '^ M')
    untracked_count=$(echo "$git_status" | grep -c '^??')

    [[ -n $BASH_VERSION ]] && echo -en " \e[32m$branch\e[0m"
    [[ -n $ZSH_VERSION ]] && echo -en " %F{2}$branch%f"

    local remote_branch
    remote_branch=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null)
    if [[ -n "$remote_branch" ]]; then
        local remote_status
        remote_status=$(git status -uno 2>/dev/null)

        if [[ $remote_status =~ Your\ branch\ is\ (ahead|behind)\ .*by\ ([0-9]+)\ commit ]]; then
            local captures
            local status_arrow

            [[ -n $BASH_VERSION ]] && captures=("${BASH_REMATCH[@]}")
            [[ -n $ZSH_VERSION ]] && captures=("${match[@]}")
            [[ ${#captures[@]} -eq 0 ]] && return 0

            [[ ${captures[1]} == "ahead" ]] && status_arrow="⇡"
            [[ ${captures[1]} == "behind" ]] && status_arrow="⇣"

            [[ -n $BASH_VERSION ]] && echo -en " \e[32m$status_arrow${captures[2]}\e[0m"
            [[ -n $ZSH_VERSION ]] && echo -en " %F{2}$status_arrow${captures[2]}%f"

        fi
    fi

    if [[ -n $BASH_VERSION ]]; then
        [[ $staged_count -gt 0 ]] && echo -en " \e[33m+$staged_count\e[0m"
        [[ $modified_count -gt 0 ]] && echo -en " \e[33m!$modified_count\e[0m"
        [[ $untracked_count -gt 0 ]] && echo -en " \e[34m?$untracked_count\e[0m"
    fi
    if [[ -n $ZSH_VERSION ]]; then
        [[ $staged_count -gt 0 ]] && echo -en " %F{3}+${staged_count}%f"
        [[ $modified_count -gt 0 ]] && echo -en " %F{3}!${modified_count}%f"
        [[ $untracked_count -gt 0 ]] && echo -en " %F{4}?${untracked_count}%f"
    fi
}

_xdg_less() {
    mkdir -p "$XDG_DATA_HOME/less"

    # ~/.lesshst
    [[ -f ~/.lesshst ]] && mv ~/.lesshst "$XDG_DATA_HOME/less/.lesshst"
    export LESSHISTFILE="$XDG_DATA_HOME/less/.lesshst"
}

_xdg_wget() {
    mkdir -p "$XDG_CONFIG_HOME/wget"
    mkdir -p "$XDG_DATA_HOME/wget"
    if [ ! -f "$XDG_CONFIG_HOME/wget/wgetrc" ]; then
        echo "hsts-file = $XDG_DATA_HOME/wget/.wget-hsts" >"$XDG_CONFIG_HOME/wget/wgetrc"

        # ~/.wget-hsts
        [[ -f ~/.wget-hsts ]] && mv ~/.wget-hsts "$XDG_DATA_HOME/wget/.wget-hsts"
    fi
    export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
}

_homedir_cleanup() {
    _xdg_less
    _xdg_wget
}

if [[ $- == *i* ]]; then
    for fn in ~/.lesshst ~/.wget-hsts; do
        if [ -f "$fn" ]; then
            _homedir_cleanup
            break
        fi
    done

    # $EDITOR
    export EDITOR='/usr/bin/vim -n'

    # $PATH: ~/.local/bin
    if ! [[ "$PATH" =~ $HOME/.local/bin ]]; then
        PATH="$HOME/.local/bin:$PATH"
    fi
    export PATH

    # $PATH: /usr/local/go/bin
    if [ -d /usr/local/go/bin ]; then
        if ! [[ "$PATH" =~ /usr/local/go/bin ]]; then
            PATH=/usr/local/go/bin:$PATH
        fi
    fi
    export PATH

    # $PATH: ~/go/bin
    if [ -d "$HOME/go/bin" ]; then
        if ! [[ "$PATH" =~ $HOME/go/bin ]]; then
            PATH="$HOME/go/bin":$PATH
        fi
    fi
    export PATH

    # $PATH: ~/.cargo/bin
    if [ -d "$HOME/.cargo/bin" ]; then
        if ! [[ "$PATH" =~ $HOME/.cargo/bin ]]; then
            PATH="$HOME/.cargo/bin":$PATH
        fi
    fi
    export PATH

    # $PATH: ~/.local/share/pnpm
    if type -P pnpm &>/dev/null; then
        export PNPM_HOME="$HOME/.local/share/pnpm"
        if ! [[ "$PATH" =~ $PNPM_HOME ]]; then
            PATH="$PNPM_HOME":$PATH
        fi
    fi

    # wezterm
    # if type -P wezterm &>/dev/null; then
    #     # eval "$(wezterm shell-completion --shell bash)"
    #     eval "$(wezterm shell-completion --shell zsh)"
    # fi

    # gitleaks
    # if type -P gitleaks &>/dev/null; then
    #     # eval "$(gitleaks completion bash)"
    #     eval "$(gitleaks completion zsh)"
    # fi

    ##
    ## Aliases and environment variables

    # less pager
    export LESS="-R" # raw output of (some) control characters
    # export LESS="-r" # more raw, if you want to display nerd font icons when git diffing

    # Alias
    [[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"
    [[ -f "$XDG_CONFIG_HOME/bash/.bash_aliases" ]] && source "$XDG_CONFIG_HOME/bash/.bash_aliases"

    # Local environment
    [[ -f "$HOME/.local/local.sh" ]] && source "$HOME/.local/local.sh"

    ##
    ## zsh specific

    # autocd
    # setopt autocd

    # Completion
    autoload -Uz compinit && compinit
    zstyle ":completion:*" menu select
    zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}" # case insensitive matching

    # History
    #HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000

    # Extended globbing, advanced pattern matching
    # setopt EXTENDED_GLOB

    # Keybinds
    bindkey -e # Emacs keybindings
    ##
    # bindkey "^R" history-incremental-search-backward # C-r history search

    # Enable substitution in the prompt
    setopt prompt_subst

    PROMPT='
    %F{6}%B%~%b%f$(prompt_git_info)
    %F{2}%B❯%b%f '

    ##
    ## shell inits

    # fzf
    if command -v fzf &>/dev/null; then
        # eval "$(fzf --bash)"
        source <(fzf --zsh)
    fi

    # zoxide, smarter cd
    # For completions to work, the above line must be added after compinit is called.
    # You may have to rebuild your completions cache by running rm ~/.zcompdump*; compinit.
    if command -v zoxide &>/dev/null; then
        # eval "$(zoxide init --cmd cd bash)"
        eval "$(zoxide init --cmd cd zsh)"
    fi

fi
