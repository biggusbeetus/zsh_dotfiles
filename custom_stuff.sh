_find() {
  local find_path=$1
  local find_options=( ${@:2} )
  fdfind $find_options --unrestricted --hidden --follow --exclude ".git" -- . $find_path
}
_fze() {
  local find_path=$2
  local command=$1
  if [[ -z $find_path ]]; then
    find_path=/
  fi
    $command $(_find $find_path | fzf ) 
}

_fzcd() {
  fuzzy() {
    fzf --preview 'tree -C {}| head -200'
  }
  local find_path=$1
  if [[ -z $find_path ]] ; then
    find_path=/
  fi
    cd $(_find $find_path --type directory | fuzzy )
}

