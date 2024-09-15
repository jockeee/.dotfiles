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
    selected=$(
        tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf \
            --height=~1% \
            --tmux=center,30%,14% \
            --layout=reverse \
            --info=inline-right \
            --color="pointer:#7c7d83,current-bg:-1" \
            --print-query | tail -1 | xargs
    )
fi

if [[ -z "$selected" ]]; then
    exit 0
fi

session_name="${selected##* }" # session_name = last item in string
tmux_running=$(pgrep tmux)

# We are not in a tmux session and tmux is not running
if [[ -z $TMUX ]] && [[ -z "$tmux_running" ]]; then
    zoxide_match=$(zoxide_query $selected)

    if [[ -z "$zoxide_match" ]]; then
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
if ! tmux has-session -t=$session_name 2>/dev/null; then
    zoxide_match=$(zoxide_query $selected)

    if [[ -z "$zoxide_match" ]]; then
        tmux new-session -d -s $session_name -c $HOME
    else
        tmux new-session -d -s $session_name -c $zoxide_match
    fi
fi

tmux switch-client -t $session_name
