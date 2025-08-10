#!/usr/bin/env bash

usage() {
    echo "Usage: $(basename "$0") [-n session_name] [path or path query]"
    echo
    echo "Options"
    echo "  -n session_name  Name of new tmux session"
    echo "  path query       Path or path query"
}

zoxide_query() {
    if ! type -P zoxide &>/dev/null; then
        return
    fi

    if [[ -n $1 ]]; then
        local query=$*
        # shellcheck disable=SC2086
        zoxide query $query 2>/dev/null
    fi
}

kill_session() {
    if [[ -z $1 ]]; then
        return
    fi

    if tmux has-session -t "$1" 2>/dev/null; then
        tmux kill-session -t "$1"
    fi
}

# -n option, session name
while getopts ":n:" opt; do
    case $opt in
    n)
        session_name="$OPTARG"
        ;;
    \?)
        usage
        exit 1
        ;;
    :)
        usage
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1)) # Remove parsed options

if [[ $# -gt 0 ]]; then
    selected=$*
else
    if [[ -n $session_name ]]; then
        echo "[INFO]: -n option ignored, no path or query provided."
    fi
    while :; do
        mapfile -t sessions < <(tmux list-sessions -F "#{session_name} #{session_last_attached}" 2>/dev/null | sort -k2r | awk '{print $1}')

        for i in "${!sessions[@]}"; do
            if [[ ${sessions[i]} == "$(tmux display-message -p '#{session_name}')" ]]; then
                sessions[i]+=" (current)"
                break
            fi
        done

        selected=$(
            printf '%s\n' "${sessions[@]}" | fzf \
                --height=~1% \
                --tmux=center,28%,10 \
                --layout=reverse \
                --info=inline-right \
                --color="pointer:#7c7d83,current-bg:-1" \
                --cycle \
                --expect=ctrl-d \
                --print-query | xargs
        )
        selected=${selected% *(current)}
        read -ra keywords <<<"$selected"

        case ${#keywords[@]} in
        0)
            # Ctrl-c / Escape / Enter, empty list (CLI)
            break
            ;;
        1)
            if [[ ${keywords[0]} == "ctrl-d" ]]; then
                # Ctrl-d, empty list
                continue
            fi
            # Enter, list item
            # Filter, Enter, no match (= new session name)
            break
            ;;
        2)
            if [[ ${keywords[0]} == "ctrl-d" ]]; then
                # Ctrl-d, list item
                kill_session "${keywords[1]}"
            else
                if [[ ${keywords[1]} == "ctrl-d" ]]; then
                    # Ctrl-d, Filter, no match
                    continue
                fi
                # Filter, Enter, match
                selected="${keywords[1]}"
                break
            fi
            ;;
        3)
            if [[ ${keywords[1]} == "ctrl-d" ]]; then
                # Ctrl-d, Filter, match
                kill_session "${keywords[2]}"
            fi
            ;;
        esac
    done
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected="${selected/#\~/$HOME}" # tilde expansion of user input from fzf popup
selected=${selected%/}           # remove trailing slash from selected, if any

if [[ -z $session_name ]]; then
    case $selected in
    "$HOME")
        session_name="home"
        ;;
    "$HOME"/.dotfiles)
        session_name="dotf"
        ;;
    esac
fi

if [[ -z $session_name ]]; then
    session_name=${selected##*[ /\\]} # session_name is the last part of selected, separators: space, \ or /
    session_name=${session_name//./}  # remove dots from session_name
fi

tmux_running=$(pgrep tmux)

# We are not in a tmux session and tmux is not running
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    zoxide_match=$(zoxide_query "$selected")

    if [[ -z $zoxide_match ]]; then
        tmux new-session -s "$session_name" -c "$HOME"
        exit 0
    fi

    tmux new-session -s "$session_name" -c "$zoxide_match"
    exit 0
fi

# We are in Tmux

# session_name is current session
if [[ $session_name == "$(tmux display-message -p '#{session_name}')" ]]; then
    exit 0
fi

# session_name does not exist
if ! tmux has-session -t "$session_name" 2>/dev/null; then
    zoxide_match=$(zoxide_query "$selected")

    if [[ -z $zoxide_match ]]; then
        tmux new-session -d -s "$session_name" -c "$HOME"
    else
        tmux new-session -d -s "$session_name" -c "$zoxide_match"
    fi
fi

tmux switch-client -t "$session_name"
