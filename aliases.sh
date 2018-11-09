###### Shortcuts #######
alias gh="cd ~"
alias gdoc="cd ~/Dokument"


# A shortcut to edit i3 config
alias i3c="cd ~/.config/i3 && vim config"

# Display an amusing message
alias lolcow="fortune | cowsay | lolcat"

# Reload the keyboard conf
alias kbconf="~/.config/autostart/kbd-setup.sh"

alias i3-start="startx ~/.xinitrc i3"
alias gnome-start="startx ~/.xinitrc gnome"
alias xmonad-start="startx ~/.xinitrc xmonad"

source ~/dotfiles/nla.sh
