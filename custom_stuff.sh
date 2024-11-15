_find() {
  local find_path=$1
  local find_options=( ${@:2} )
  find ${find_path} $find_options 2> /dev/null
}

_fuzzy_execute() {
  local find_path=$2
  local command=$1
  if [[ -z $find_path ]]; then
    find_path=.
  fi
    local result=$(_find $find_path | fzf ) 
  if [[ -d $result ]]; then
     cd $result 
   else
     cd $(dirname $result)
  fi
    $command $(basename $result[@])
}

_fuzzy_cd() {
  fuzzy() {
    fzf --preview 'tree -C {}| head -200'
  }
  local find_path=$1
  if [[ -z $find_path ]] ; then
    find_path=.
  fi
    cd "$(_find $find_path -type d | fuzzy )"
}

_source_zsh() {
  source $XDG_CONFIG_HOME/zsh/.zshrc
}
