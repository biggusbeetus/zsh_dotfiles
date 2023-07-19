alias -g ls="exa"
alias -g ll="exa -l"
alias -g la="exa -al"

if [[ $OSTYPE != *freebsd* ]]; then
  echo $OSTYPE 
  alias -g bat="batcat";
  alias -g bman="batman";
  alias -g brg="batgrep";
  alias -g pbat="prettybat";
  alias -g fd="fdfind";
fi

alias -g fcd=_fuzzy_cd
alias -g fe=_fuzzy_execute

alias python='python3'
alias nyxt='flatpak run engineer.atlas.Nyxt'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
