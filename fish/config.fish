if status is-interactive
  # Commands to run in interactive sessions can go here
end

# Add to fish
direnv hook fish | source
zoxide init fish | source
fzf --fish | source

set fish_greeting
set PATH $PATH /opt/homebrew/bin/
set PATH $PATH /Users/roberto/.cargo/bin
set PATH $PATH /Users/roberto/.local/bin

alias g="git"
alias v="nvim"

function work
  cd /Volumes/Workspace
end

function rl
  echo "Reloading fish config..."
  . ~/.config/fish/config.fish
end

function kp --description "Kill processes"
  set -l __kp__pid (ps -ef | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]'" | awk '{print $2}')
  set -l __kp__kc $argv[1]

  if test "x$__kp__pid" != "x"
    if test "x$argv[1]" != "x"
      echo $__kp__pid | xargs kill $argv[1]
    else
      echo $__kp__pid | xargs kill -9
    end
    kp
  end
end

function ks --description "Kill http server processes"
  set -l __ks__pid (lsof -Pwni tcp | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:tcp]'" | awk '{print $2}')
  set -l __ks__kc $argv[1]

  if test "x$__ks__pid" != "x"
    if test "x$argv[1]" != "x"
      echo $__ks__pid | xargs kill $argv[1]
    else
      echo $__ks__pid | xargs kill -9
    end
    ks
  end
end
