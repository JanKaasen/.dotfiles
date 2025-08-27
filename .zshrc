alias n="nvim"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.local/scripts:$PATH"
export PATH=/home/jan/.cargo/bin:$PATH
export PATH=/home/jan/.local/bin:$PATH
export PATH="$HOME/.cabal/bin:$PATH"
export EDITOR='nvim'
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
# export PATH="$(brew --prefix)/opt/python@3/libexec/bin:$PATH"

mvnrun() {
  if [ -f "pom.xml" ]; then
    if [ "$#" -eq 0 ]; then
      echo "Usage: mvnrun <mainClass>"
      return 1
    fi
    mvn compile exec:java -Dexec.mainClass="$1"
  else
    echo "Error: No pom.xml found in current directory"
    return 1
  fi
}

bindkey -s ^f "tmux-sessionizer\n"


[ -f "/home/jan/.ghcup/env" ] && . "/home/jan/.ghcup/env" # ghcup-env

eval "$(starship init zsh)"
