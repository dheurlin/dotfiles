# QuickLook file from terminal
ql(){
    qlmanage -p "$1" &> /dev/null
}

# simple command for showing/hiding hidden files
alias hfile='/Applications/shellscripts/hfile.sh'

# simplified way of downloading files into directory
alias dl='curl -O'

# A program that shows the next departures from a given tram stop (Västtrafik)
alias td='~/Dropbox/coding\ stuff/TramDisplay/TramDisplay'

# A command for resizing the current window to a percentage of the total screen, and cenering it
# example: rsc 0.8 resizes the window to 80% of the screen size, and puts it in the center
alias rsc='osascript ~/Dropbox/coding\ stuff/applescript/resize-iterm.scpt'

# A command to compile all .pmd files in all subdirectories into a master pdf
alias pmd-to-master='~/Dropbox/coding\ stuff/bash/pmds-to-master-pdf.sh'

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

# setup shortcut for sublime text
#ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.symlinks/subl
#### OLD WAY ---- alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# shortcut for sleeping display
ds(){
    pmset displaysleepnow
}
