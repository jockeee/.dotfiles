#!/usr/bin/env bash

zoxide_query() {
    if ! type -P zoxide &>/dev/null; then
        echo ""
    fi

    if [[ -z "$1" ]]; then
        echo ""
    else
        echo $(zoxide query $@ 2>/dev/null)
    fi
}

if [[ $# -gt 0 ]]; then
    selected=$@
else
    while :; do
        selected=$(
            tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf \
                --height=~1% \
                --tmux=center,30%,14% \
                --layout=reverse \
                --info=inline-right \
                --color="pointer:#7c7d83,current-bg:-1" \
                --cycle \
                --expect=ctrl-d \
                --print-query | xargs
        )

        IFS=' ' read -ra list <<<"$selected"

        if [[ ${#list[@]} -lt 2 ]]; then
            # User selected or aborted
            break
        fi

        if [[ ${#list[@]} -eq 2 ]]; then
            # Expect triggered
            key_pressed=${list[0]}
            session_name=${list[1]}

            case "$key_pressed" in
            "ctrl-d")
                # Ctrl-d, Delete session
                if tmux has-session -t $session_name 2>/dev/null; then
                    tmux kill-session -t $session_name
                fi
                ;;
            esac
        fi
    done
fi

if [[ -z "$selected" ]]; then
    exit 0
fi

selected="${selected/#\~/$HOME}" # tilde expansion of user input from fzf popup
selected=${selected%/}           # remove trailing slash from selected, if any

if [[ $selected == $HOME ]]; then
    selected="base"
fi

session_name=${selected##*[ /\\]} # session_name is the last part of selected, separators: space, \ or /
session_name=${session_name//./}  # remove dots from session_name
tmux_running=$(pgrep tmux)

# We are not in a tmux session and tmux is not running
if [[ -z $TMUX ]] && [[ -z "$tmux_running" ]]; then
    zoxide_match=$(zoxide_query $selected)

    if [[ -z $zoxide_match ]]; then
        tmux new-session -s $session_name -c $HOME
        exit 0
    fi

    tmux new-session -s $session_name -c $zoxide_match
    exit 0
fi

# We are in Tmux

# session_name is current session
if [[ $session_name == $(tmux display-message -p '#S') ]]; then
    exit 0
fi

# session_name does not exist
if ! tmux has-session -t $session_name 2>/dev/null; then
    zoxide_match=$(zoxide_query $selected)

    if [[ -z $zoxide_match ]]; then
        tmux new-session -d -s $session_name -c $HOME
    else
        tmux new-session -d -s $session_name -c $zoxide_match
    fi
fi

tmux switch-client -t $session_name
