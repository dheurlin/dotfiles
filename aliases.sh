###### Shortcuts #######
alias gh="cd ~"
alias gdoc="cd ~/Dokument"

## Shortcuts for exa
# (letters are chosen to be analagous to l and ls)
alias eh="exa --header --long --grid --git"
alias e="eh -a"
alias es="exa"


# A shortcut to edit i3 config
alias i3c="cd ~/.config/i3 && vim config"

# Display an amusing message
alias lolcow="fortune | cowsay | lolcat"

# Reload the keyboard conf
alias kbconf="~/.config/autostart/kbd-setup.sh"

# Aliases for starting different window managers/desktop environments
alias i3-start="startx ~/.xinitrc i3"
alias gnome-start="startx ~/.xinitrc gnome"
alias xmonad-start="startx ~/.xinitrc xmonad"

source ~/dotfiles/nla.sh
