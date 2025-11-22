#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

# kitty terminal background opacity option
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    ln -sf ~/hypr-config/.config/kitty/kitty-gnome.conf ~/hypr-config/.config/kitty/kitty.conf
else
    ln -sf ~/hypr-config/.config/kitty/kitty-hyprland.conf ~/hypr-config/.config/kitty/kitty.conf
fi


export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx

# neofetch
alias gurafetch='neofetch --source ~/Downloads/ascii/gura2.txt'

# compile c++ script
cc(){
	g++ -o $1 $1.cpp -DDEBUG -Wall -Wshadow -Wextra -std=c++20
}
# compile and run c++ script
cr(){
	g++ -o $1 $1.cpp -DDEBUG -Wall -Wshadow -Wextra -std=c++20
	./$1
}
rs(){
	cp ~/comprog/template.cpp $1.cpp
}

batlyfe(){
	upower -i /org/freedesktop/UPower/devices/battery_BAT1
}

# android studio
export ANDROID_HOME=$HOME/Android/Sdk 
export PATH=$PATH:$ANDROID_HOME/emulator 
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools 
export QT_QPA_PLATFORM=xcb 


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
