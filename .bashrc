# default distro ~/.bashrc above
# VERSION 1.0.8

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

alias c='cat'
if type -P bat &>/dev/null; then
  alias bat='bat -p'
  alias c='bat'
fi

if type -P batcat &>/dev/null; then
  alias bat='batcat -p'
  alias c='bat'
fi

if type -P /usr/bin/eza &>/dev/null; then
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

if type -P /usr/bin/btop &>/dev/null; then
  alias top='btop'
fi

alias g='git'
alias v='vim'

# tmux
alias s='tmux attach || tmux new-session -s base'
alias ss='tmux new-session -A -s'
alias sx='tmux kill-session -t'
alias sl='tmux list-sessions'

# git
alias ga='git add'
alias gc='git commit -m'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gp='git push'
alias gpl='git pull'
alias gr='git remote -v'
alias grs='git reset'
alias grs!='git reset --hard'
alias gs='git status'

##
## Functions
##

# upd (fedora/ubuntu) - bash style

upd_fedora() {
  echo -e '\e[1mUpdating system\e[0m'
  echo -e '\e[3msudo dnf upgrade\e[0m\n'
  sudo dnf upgrade -y
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
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
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

    # if neither curl nor wget found, exit
    if ! type -P /usr/bin/curl &>/dev/null && ! type -P /usr/bin/wget &>/dev/null; then
      echo "Error: Neither 'curl' nor 'wget' found"
      return 1
    fi

    # if jq not found, exit
    if ! type -P /usr/bin/jq &>/dev/null; then
      echo "Error: 'jq' not found"
      return 1
    fi

    os=$(uname -s | tr '[:upper:]' '[:lower:]')
    arch=$(uname -m)
    if [ $arch == 'x86_64' ]; then
      arch='amd64'
    fi
    kind='archive'
    temp_file="/tmp/tmp.golang_install"
    download_url_base='https://golang.org/dl/'

    # download json
    if type -P /usr/bin/curl &>/dev/null; then
      go_dev_json=$(curl -s https://go.dev/dl/?mode=json)
    else
      go_dev_json=$(wget -qO- https://go.dev/dl/?mode=json)
    fi

    if [ $? -ne 0 ]; then
      echo "Error: Couldn't retrieve JSON response from 'https://go.dev/dl/?mode=json'"
      rm $temp_file
      return 1
    fi

    current_go_version=$(/usr/local/go/bin/go version | awk '{print $3}')
    latest_go_version=$(echo $go_dev_json | jq -r '.[0].version')

    current_major=$(echo $current_go_version | sed 's/go//' | cut -d. -f1)
    current_minor=$(echo $current_go_version | sed 's/go//' | cut -d. -f2)
    current_patch=$(echo $current_go_version | sed 's/go//' | cut -d. -f3)

    latest_major=$(echo $latest_go_version | sed 's/go//' | cut -d. -f1)
    latest_minor=$(echo $latest_go_version | sed 's/go//' | cut -d. -f2)
    latest_patch=$(echo $latest_go_version | sed 's/go//' | cut -d. -f3)

    need_update=false
    if [ $current_major -lt $latest_major ]; then
      need_update=true
    elif [ $current_major -eq $latest_major ]; then
      if [ $current_minor -lt $latest_minor ]; then
        need_update=true
      elif [ $current_minor -eq $latest_minor ]; then
        if [ $current_patch -lt $latest_patch ]; then
          need_update=true
        fi
      fi
    fi

    selected_json=$(echo $go_dev_json | jq -r --arg os "$os" --arg arch "$arch" --arg kind "$kind" --arg version "$latest_go_version" '.[0].files[] | select(.os == $os and .arch == $arch and .kind == $kind and .version == $version)')

    # if selected_json isn't empty, set download_filename and download_checksum
    if [ -n "$selected_json" ]; then
      download_filename=$(echo $selected_json | jq -r '.filename')
      download_checksum=$(echo $selected_json | jq -r '.sha256')
    else
      echo "Error: Couldn't find the latest version for $os-$arch in the JSON response."
      return 1
    fi

    if [ $need_update == true ]; then
      echo "Update available: $current_go_version -> $latest_go_version"
      echo

      # read -p "Do you want to update? [y/N] " -n 1 -r
      # if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      #   return 0
      # fi
      # echo

      # download go
      if type -P /usr/bin/curl &>/dev/null; then
        curl -L -o $temp_file $download_url_base$download_filename
      else
        wget -q --show-progress -O $temp_file $download_url_base$download_filename
      fi

      if [ $? -ne 0 ]; then
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

      # verify checksum
      checksum=$(sha256sum $temp_file | cut -d' ' -f1)
      if [ $checksum != $download_checksum ]; then
        echo "Error: Checksum verification failed"
        rm $temp_file
        return 1
      fi

      # update
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
  sed -i '/# default distro ~\/.bashrc above/,$ d' ~/.bashrc
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't clean ~/.bashrc from current additions."
    mv ~/.bashrc.bak ~/.bashrc
    return 1
  fi

  # add new additions
  cat ~/.dotfiles/.bashrc >>~/.bashrc
  if [ $? -ne 0 ]; then
    echo "Error: Couldn't update ~/.bashrc"
    mv ~/.bashrc.bak ~/.bashrc
    return 1
  fi

  # source ~/.bashrc
  source ~/.bashrc
  if [ $? -ne 0 ]; then
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

# autocd
shopt -s autocd

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
