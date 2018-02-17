# QuickLook file from terminal
ql(){
    qlmanage -p "$1" &> /dev/null
}

# simple command for showing/hiding hidden files
alias hfile='/Applications/shellscripts/hfile.sh'

# simplified way of downloading files into directory
alias dl='curl -O'

# A program that shows the next departures from a given tram stop (Västtrafik)
alias td='python3.5 ~/Dropbox/coding\ stuff/TramDisplay/TramDisplay'

# A command for resizing the current window to a percentage of the total screen, and cenering it
# example: rsc 0.8 resizes the window to 80% of the screen size, and puts it in the center
alias rsc='osascript ~/Dropbox/coding\ stuff/applescript/resize-iterm.scpt'

# A command to compile all .pmd files in all subdirectories into a master pdf
alias pmd-to-master='~/Dropbox/coding\ stuff/bash/pmds-to-master-pdf.sh'

# A command to synchronize a youtube playlist
yt-sync() { ~/Dropbox/coding\ stuff/bash/sync-youtube-playlist.sh "$@" }

# Vim should be the macvim executable
# alias vim="/usr/local/Cellar/macvim/8.0-144_3/MacVim.app/Contents/bin/vim"

# A shortcut to edit .zshrc
alias zrc="vim ~/dotfiles/.zshrc"

# Display an amusing message
alias lolcow="fortune | cowsay | lolcat"

# a shortcut to the spotify download program
# alias spotdl='python3 ~/.userbin/src/spotify-downloader/spotdl.py'
spotdl() {
    # spotdl thinks it is in ~, so we must adjust the path to make it absolute
    matches=$(echo "$@" | grep -oh -e '\-f\s\S*' -e '\-\-folder\s\S*')
    rc=$?; if [[ $rc == 0 ]]; then
        file=$(echo ${matches[0]} | cut -d' ' -f2-)
        file=$(greadlink -f $file) # convert to absolute path
        file=$(echo $file | sed -e 's/[]\/$*.^|[]/\\&/g') # escape illegal chars
        match=$(echo ${matches[0]} | sed -e 's/[\/&]/\\&/g')
        args=$(echo "$@" | sed "s/$match/ \-f $file/g") # replace the illegal shit with the real shit
    else
        args="$@"
    fi

    python3 ~/.userbin/src/spotify-downloader/spotdl.py $args
}

# Open zathura as background process
zath() {
    (zathura "$1" &)
}

# setup shortcut for sublime text
#ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.symlinks/subl
#### OLD WAY ---- alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# shortcut for sleeping display
ds(){
    pmset displaysleepnow
}

## Aliases for controlling gnome night light

# A global variable keeping thrack of the current temp
export PUSHED_NL_TEMP=${PUSHED_NL_TEMP:-5000}

# get the current temp
nl-get-curr() {
    # get the current value (will return "uint32 XXXX")
    curr=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-temperature)
    # extract the temperature (get the XXXX from above) and store it in a global variable
    echo $(echo $curr | cut -d " " -f 2)
}

## Open gnome-night-light-adjuster
set-nla-alias() {
    alias nla="gnome-night-light-adjuster"
}

set-nla-alias

## Disables the night light, after saving the current temperature to a variable
# so that it can be restored later
nld() {
    # Save the current temp
    export PUSHED_NL_TEMP=$(nl-get-curr)

    # Set the temp to minimum
    gnome-night-light-adjuster 6500 &>/dev/null

    # temporarily disable nla command to avoid interference
    alias nla="echo 'Re-enable night light by running nlr before adjusting temperature!'"
}

## Restores the night light to what is was before nld was called
nlr() {
    gnome-night-light-adjuster $PUSHED_NL_TEMP &>/dev/null
    # re-enable nla alias
    set-nla-alias
}
