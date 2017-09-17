local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

venv_prefix="%{$fg[green]%}(%{$fg[yellow]%}"
venv_suffix="%{$fg[green]%})%{$reset_color%} "
venv_name() {
    if [[ $VIRTUAL_ENV == "" ]]; then
        echo -n ""
    else
        echo -n "$venv_prefix$(basename $VIRTUAL_ENV)$venv_suffix"
    fi
}
local venv_prompt="\$(venv_name)"

# White $, with red bg if normal mode, and no bg otherwise
vi_curr_mode() {
    if [[ $(vi_mode_prompt_info) == "" ]]; then
        echo -n "%B$%b% "
    else
        echo -n "%{$fg[white]$bg[red]%}%B$%b%{$reset_color%}"
    fi
}
# RPROMPT='$(vi_curr_mode)'

PROMPT="╭ ${venv_prompt}${user_host} ${current_dir} ${rvm_ruby} ${git_branch}
╰ \$(vi_curr_mode) " 
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}(%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}) %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%})"


# disable default venv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"

