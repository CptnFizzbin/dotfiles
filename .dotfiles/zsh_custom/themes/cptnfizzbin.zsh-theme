# Based on gnzh theme

setopt prompt_subst

parse_version_string () {
  while read -r data; do
    echo "$data" | grep -o -m 1 -P '(\d+\.?)+' | head -1
  done
}

python_prompt_info () {
  local version="$(python --version | parse_version_string)"
  echo "${ZSH_THEME_PYTHON_PROMPT_PREFIX}${version:gs/%/%%}${ZSH_THEME_PYTHON_PROMPT_SUFFIX}"
}

node_prompt_info () {
  local version="$(node --version | parse_version_string)"
  echo "${ZSH_THEME_NODE_PROMPT_PREFIX}${version:gs/%/%%}${ZSH_THEME_NODE_PROMPT_SUFFIX}"
}

ruby_prompt_info () {
  local version="$(ruby --version | parse_version_string)"
  echo "${ZSH_THEME_RUBY_PROMPT_PREFIX}${version:gs/%/%%}${ZSH_THEME_RUBY_PROMPT_SUFFIX}"
}

() {
local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{yellow}%M%f' # SSH
else
  PR_HOST='%F{green}%M%f' # no SSH
fi

local os_name="$(grep -E '^NAME=' /etc/os-release | sed -En 's/NAME=\"(.*)\"/\1/p')"
local return_code="%(?..%F{red}‹%? ↵›%f)"
local user_host="${PR_USER}%F{cyan}@${PR_HOST} [${os_name}]"
local current_dir="%B%F{blue}%(5~|%-1~/…/%3~|%4~)%f%b"

ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"

ZSH_THEME_NODE_PROMPT_PREFIX="%F{green}‹"
ZSH_THEME_NODE_PROMPT_SUFFIX="›%f"

ZSH_THEME_PYTHON_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_PYTHON_PROMPT_SUFFIX="›%f"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{cyan}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%f"

PROMPT="╭─${user_host} \$(node_prompt_info) \$(ruby_prompt_info) \$(python_prompt_info)${return_code}
├ ${current_dir} \$(git_prompt_info)
╰─$PR_PROMPT "
}
