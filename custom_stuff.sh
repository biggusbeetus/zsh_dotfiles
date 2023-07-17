_find() {
  local find_path=$1
  local find_options=( ${@:2} )
  fdfind $find_options --unrestricted --hidden --follow --exclude ".git" -- . $find_path
}

_fuzzy_execute() {
  local find_path=$2
  local command=$1
  if [[ -z $find_path ]]; then
    find_path=/
  fi
    local result=$(_find $find_path | fzf ) 
  if [[ -d $result ]]; then
     cd $result 
   else
     cd $(dirname $result)
  fi
    $command $result[@]
}

_fuzzy_cd() {
  fuzzy() {
    fzf --preview 'tree -C {}| head -200'
  }
  local find_path=$1
  if [[ -z $find_path ]] ; then
    find_path=/
  fi
    cd $(_find $find_path --type directory | fuzzy )
}

