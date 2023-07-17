_find() {
  fdfind --hidden --follow --exclude ".git" . $path
}
_fze() {
  fuzzy() {
    fzf --preview 'batcat -n --color=always {}' 
  }
  if [[ -n $2 ]]; then
    $1 $(_find $2 | fuzzy) 
  else
    $1 $(_find . | fuzzy )
  fi

}

_fzcd() {
  fuzzy() {
    fzf --preview 'tree -C {}| head -200'
  }
  if [[ -n $1 ]] ; then
    cd $(_find $1 | fuzzy )
  else
    cd $(_find . | fuzzy )
  fi
}

