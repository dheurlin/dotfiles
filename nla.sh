## Aliases for controlling gnome night light

# A global variable keeping thrack of the current temp
export NLA_PUSHED_TEMP=${NLA_PUSHED_TEMP:-5000}
# A variable telling us whether nla is temporarily disabled
export NLA_DISABLED=${NLA_DISABLED:-0}

# get the current temp
nl-get-curr() {
    # get the current value (will return "uint32 XXXX")
    curr=$(gsettings get org.gnome.settings-daemon.plugins.color night-light-temperature)
    # extract the temperature (get the XXXX from above) and store it in a global variable
    echo $(echo $curr | cut -d " " -f 2)
}

## Open gnome-night-light-adjuster
# set-nla-alias() {
#     alias nla="_nla"
# }

alias nla="_nla"

# A wrapper around gnome-night-light-adjuster,
# which also allows relative adjustments using +/-
_nla() {
    arg="$1"

    # If we give it an argument, we are allowed to modify it
    if [[ $arg != "" ]]; then export NLA_DISABLED=0; fi

    # If we give it + or -, calculate the new temperature relative to the old one
    if [[ ${arg:0:1} == "+" ]]; then
        newTemp=$(($(nl-get-curr) + ${arg:1}))
    elif [[ ${arg:0:1} == "-" ]]; then
        newTemp=$(($(nl-get-curr) - ${arg:1}))
    else
        newTemp=$arg
    fi

    if (( $NLA_DISABLED != 1 )); then
    gnome-night-light-adjuster $newTemp
    else
        echo "Restore night light using nlr before adjutsing!"
    fi
}

# set-nla-alias

## Disables the night light, after saving the current temperature to a variable
# so that it can be restored later
nld() {
    if (( $NLA_DISABLED != 1 )); then
        # Save the current temp
        export NLA_PUSHED_TEMP=$(nl-get-curr)

        # Set the temp to minimum
        gnome-night-light-adjuster 6500 &>/dev/null

        # temporarily disable nla command to avoid interference
        export NLA_DISABLED=1
        # alias nla="echo 'Re-enable night light by running nlr before adjusting temperature!'"
    fi
}

## Restores the night light to what is was before nld was called
nlr() {
    gnome-night-light-adjuster $NLA_PUSHED_TEMP &>/dev/null
    # re-enable nla alias
    export NLA_DISABLED=0
    # set-nla-alias
}
