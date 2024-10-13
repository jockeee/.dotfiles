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

        # Variable `selected` variations
        # [filter keyword] [triggered expect] [item match in list, if any]
        #
        #     ACTION                      RETURN            0  1  2  3 (keywords returned)
        #     Ctrl-c / Escape             (nothing)         0          |_ 1 CASE = exit
        #     Enter, list item            code                 1       |  4* CASES (3 technically in code, 2 cases handled in the same way, 1 edge case)
        #     Filter, Enter, no match     co                   1       |  ^ Treat as above = User gives session name = Create it if it doesn't exist
        #     Ctrl-d, empty list          ctrl-d               1       |_ ^
        #     Ctrl-d, list item           ctrl-d code             2    |  3 CASES
        #     Filter, Enter, match        co code                 2    |  ^
        #     Ctrl-d, Filter, no match    co ctrl-d               2    |_ ^
        #     Ctrl-d, Filter, match       co ctrl-d code             3 |  1 CASE
        #
        #     *Edge case, session_name ctrl-d exist
        #     (yes it is stupid, but now you got here, and it works...) Can't read the code anymore but HEY! it works.
        #     Enter, list item            ctrl-d               1       |  4* CASES (3 technically in code, 2 cases handled in the same way, 1 edge case)

        case ${#keywords[@]} in
        0)
            # Ctrl-c / Escape
            # ''
            break
            ;;
        1)
            if [[ ${keywords[0]} == "ctrl-d" ]]; then
                if tmux has-session -t ${keywords[0]} 2>/dev/null; then
                    # *Edge case, session_name ctrl-d exist
                    # Enter, list item
                    # 'ctrl-d'
                    break
                fi
                # Ctrl-d, empty list
                # 'ctrl-d'
                continue
            fi
            # Enter, list item
            # 'code'
            # Filter, Enter, no match (create new session from name)
            # 'co'
            break
            ;;
        2)
            if [[ ${keywords[0]} == "ctrl-d" ]]; then
                # Ctrl-d, list item
                # 'ctrl-d code'
                session_name=${keywords[1]}
                kill_session $session_name
            else
                if [[ ${keywords[1]} == "ctrl-d" ]]; then
                    # Ctrl-d, Filter, no match
                    # 'co ctrl-d'
                    continue
                fi
                # Filter, Enter, match
                # 'co code'
                session_name=${keywords[1]}
                selected=$session_name
                break
            fi
            ;;
        3)
            if [[ ${keywords[1]} == "ctrl-d" ]]; then
                # Ctrl-d, Filter, match
                # 'co ctrl-d code'
                session_name=${keywords[2]}
                kill_session $session_name
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
