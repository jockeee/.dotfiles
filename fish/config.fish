if status is-interactive
  # Set fish_greeting to empty = not showing
  set -U fish_greeting

  # Remove underlines
  set fish_color_valid_path                        # default: '--underline'
  set fish_pager_color_prefix 'normal' '--bold'    # default: 'normal'  '--bold'  '--underline'

  # $EDITOR
  set -Ux EDITOR '/usr/bin/vim'

  # Title
  # Default shows truncated directories like ~/.d/f/config.fish
  # Default function: `functions fish_title`
  # Modified `prompt_pwd -d 1 -D 1` to `prompt_pwd -d 0 -D 0`
  # https://fishshell.com/docs/current/cmds/fish_title.html
  # https://fishshell.com/docs/current/cmds/prompt_pwd.html
  #
  # Defined in /usr/share/fish/functions/fish_title.fish @ line 1
  function fish_title
    # emacs' "term" is basically the only term that can't handle it.
    if not set -q INSIDE_EMACS; or string match -vq '*,term:*' -- $INSIDE_EMACS
      # If we're connected via ssh, we print the hostname.
      set -l ssh
      set -q SSH_TTY
      and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"
      # An override for the current command is passed as the first parameter.
      # This is used by `fg` to show the true process name, among others.
      if set -q argv[1]
        echo -- $ssh (string sub -l 20 -- $argv[1]) (prompt_pwd -d 0 -D 0)
      else
        # Don't print "fish" because it's redundant
        set -l command (status current-command)
        if test "$command" = fish
          set command
        end
        echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d 0 -D 0)
      end
    end
  end

  # Alias
  if test -f $HOME/.config/fish/alias.fish
      source $HOME/.config/fish/alias.fish
  end

  # $PATH: ~/.local/bin
  if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
  end

  # $PATH: /usr/local/go/bin
  if test -d /usr/local/go/bin
    fish_add_path /usr/local/go/bin
  end

  # $PATH: ~/go/bin
  if test -d $HOME/go/bin
    fish_add_path $HOME/go/bin
  end

  # $PATH: ~/.cargo/bin
  if test -d $HOME/.cargo/bin
    fish_add_path $HOME/.cargo/bin
  end

  # Zoxide, smarter cd
  if command -q zoxide
    zoxide init --cmd cd fish | source
  end

  # fzf
  if command -q fzf
    fzf --fish | source
  end

  # npm via nvm, and plugin jorgebucaran/nvm.fish
  if functions -q nvm
    nvm use lts 1>/dev/null
  end
end
