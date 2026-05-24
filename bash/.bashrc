#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx

# neofetch
alias gurafetch='neofetch --source ~/Downloads/ascii/gura2.txt'

gurafetch

# compile c++ script
cc() {
  clang++ $1.cpp -o $1 -Wall -Wextra -Wshadow -D_GLIBCXX_DEBUG -DDEBUG
}
# compile and run c++ script
cr() {
  clang++ $1.cpp -o $1 -Wall -Wextra -Wshadow -D_GLIBCXX_DEBUG -DDEBUG &&
    echo "compiled successfully!" &&
    ./$1
}
# reset file from template
rs() {
  cp ~/comprog/template.cpp $1.cpp
  tmp=$(mktemp)

  echo "// created at: $(date '+%Y-%m-%d %H:%M:%S')" >"$tmp"
  cat "$1.cpp" >>"$tmp"

  mv "$tmp" "$1.cpp"
}

# battery health check
batlyfe() {
  upower -i /org/freedesktop/UPower/devices/battery_BAT1
}

# open file manager
open() {
  # if no argument passed, use current location
  local target="${1:-.}"

  GTK_USE_PORTAL=0 nautilus "$target" &>/dev/null &
  disown
}

# android studio
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
# export QT_QPA_PLATFORM=xcb

# air for live refresh in go webdev
export PATH=$PATH:$(go env GOPATH)/bin

# Created by `pipx` on 2025-08-06 14:30:19
export PATH="$PATH:/home/david/.local/bin"

# pnpm
export PNPM_HOME="/home/david/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# cargo from rust
export PATH="$HOME/.cargo/bin:$PATH"
