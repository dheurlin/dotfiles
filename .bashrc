# source the path containing our path
source ~/dotfiles/path.sh

# Make bash use vim bindings
set -o vi

### PROMPT CONFIG
# old: PS1=\h:\W \u\$
# newer:
# export PS1='\033[32m\u\033[m @ \033[31m\h : \033[m\033[105;30m\w\033[m \n$ '
# Add git plugin
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
#helper function to make the arrow
rarr() {
    bg=$1
    fg=$2
    printf "\033[${fg};${bg}m"
}

# the colors used, both bg and fg values
fven="33"
bven="41"
fusr="32"
busr="100"
fgit="90"
bgit="100"
fpath="32"
bpath="42"

# dont use default vitrtualenv prompt, use custom instead
export VIRTUAL_ENV_DISABLE_PROMPT=1
# print current virtualenv, if it exists
venv() {
    if [[ $VIRTUAL_ENV == "" ]]; then
        printf ""
    else
        printf "\033[${fven}m($(basename $VIRTUAL_ENV)) "
    fi
}

# Prints the current git branch if it exists, otherwise print noting
gitbr() {
    if [[ $git_branch == "" ]]; then
        printf ""
    else
        # remove brackets from branch name
        gb=${git_branch#"("}
        gb=${gb%")"}
        gd=""
        # print dirty if exists
        if [[ $git_dirty != "" ]]; then
            gd="\033[91m${git_dirty} " 
        fi
        printf " $gb $gd "
    fi
}
usr="\033[${fusr}m\u\033[m : "
path="\033[105;30m\w\033[m "
export PS1="\$(venv)${usr}${path}\$(gitbr)\033[m \n$ " 

# remove duplicates from PROMPT_COMMAND, since sourcing bash_profile adds some stuff again
# without checking if it's already there, causing lag
# export PROMPT_COMMAND
# export PROMPT_COMMAND=$(python3 -c 'import os; l = os.environ["PROMPT_COMMAND"].split("; "); print("; ".join(set(l)))')


### END OF PROMPT CONFIG


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

source ~/dotfiles/aliases.sh

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
