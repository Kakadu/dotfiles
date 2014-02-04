alias aptin='sudo aptitude   install'
alias aptup='sudo aptitude   update'
alias aptp='sudo  aptitude purge'
alias aptrm='sudo aptitude remove'
alias apts='aptitude search'
alias aptsh='aptitude show'

alias sduo=sudo
alias suod=sudo
alias mkae=make

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'

alias grep='grep --color=auto -n'

alias ocaml='rlwrap ocaml'

function svndiff() {
  svn diff $@ 2>&1 > /tmp/svndiff.diff
  vim /tmp/svndiff.diff
}
