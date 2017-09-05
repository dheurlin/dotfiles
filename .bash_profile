# set PATH
export PATH=/Applications/codelite.app/Contents/SharedSupport:$HOME/arm-none-eabi/bin:$PATH
export PATH=/Applications/XAMPP/xamppfiles:$PATH
export PATH=~/.symlinks:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/Library/Haskell/bin:$PATH" # add cabal packages
export PATH="/Applications/MacVim.app/Contents/bin:$PATH" # Add mac vim
export PATH="/Applications/VLC.app/Contents/MacOS:$PATH" # Add VLC
export PATH="/Users/danielheurlin/.erlangInstaller/20.0/bin:$PATH" # Add erlang

# Make bash use vim bindings
set -o vi

# change command line prompt
# old: PS1=\h:\W \u\$
export PS1='\033[32m\u\033[m @ \033[31m\h : \033[m\033[105;30m\w\033[m \n$ '

export LC_ALL='sv_SE.UTF-8'
# add colors to command line
# # export CLICOLOR=1
# # export LSCOLORS=ExFxBxDxCxegedabagacad

## LESS config
# enable syntax highlighting
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "

# show line numbers by defult
export LESS=" -N $LESS"



# preferred ls setup
alias ls='ls -GFh'

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

# setup shortcut for sublime text
#ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ~/.symlinks/subl
#### OLD WAY ---- alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# shortcut for sleeping display
ds(){
    pmset displaysleepnow
}

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

########################################################################
# Setup python Virtual Environment #####################################
########################################################################
export PYTHONPATH=${PYTHONPATH}:/usr/bin
VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/3.5/bin/python3.5
export WORKON_HOME=~"$HOME/.virtualenvs"
source /Library/Frameworks/Python.framework/Versions/3.5/bin/virtualenvwrapper.sh

# shortcut to make a virtual environment for python 3
alias mkvirtualenv3='mkvirtualenv --python=/Library/Frameworks/Python.framework/Versions/3.5/bin/python3'
# End of Python virtual envs ###########################################

##
# Your previous /Users/danielheurlin/.bash_profile file was backed up as /Users/danielheurlin/.bash_profile.macports-saved_2017-08-01_at_17:39:39
##

# MacPorts Installer addition on 2017-08-01_at_17:39:39: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"