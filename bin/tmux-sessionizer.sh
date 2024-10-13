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

kill_session() {
    if [[ -z $1 ]]; then
        return
    fi

    if tmux has-session -t $1 2>/dev/null; then
        tmux kill-session -t $1
    fi
}

if [[ $# -gt 0 ]]; then
    selected=$@
else
    while :; do
        selected=$(
            tmux list-sessions -F "#{session_name} #{session_last_attached}" 2>/dev/null | sort -k2r | awk '{print $1}' | fzf \
                --height=~1% \
                --tmux=center,30%,14% \
                --layout=reverse \
                --info=inline-right \
                --color="pointer:#7c7d83,current-bg:-1" \
                --cycle \
                --expect=ctrl-d \
                --print-query | xargs
        )
        IFS=' ' read -ra keywords <<<"$selected"

        case ${#keywords[@]} in
        0)
            break
            ;;
        1)
            if [[ ${keywords[0]} == "ctrl-d" ]]; then
                continue
            fi
            break
            ;;
        2)
            if [[ ${keywords[0]} == "ctrl-d" ]]; then
                kill_session ${keywords[1]}
            else
                if [[ ${keywords[1]} == "ctrl-d" ]]; then
                    continue
                fi
                selected=${keywords[1]}
                break
            fi
            ;;
        3)
            if [[ ${keywords[1]} == "ctrl-d" ]]; then
                kill_session ${keywords[2]}
            fi
            ;;
        esac
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
