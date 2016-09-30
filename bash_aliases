alias aptin='sudo apt-fast install'
alias aptup='sudo apt-fast update'
alias aptsup='sudo apt-fast safe-upgrade'
alias aptp='sudo  aptitude purge'
alias aptrm='sudo aptitude remove'
alias aptre='sudo apt-fast reinstall'
alias apts='aptitude search'
alias aptsh='aptitude show'

alias sduo=sudo
alias suod=sudo
alias mkae=make
alias qmkae=qmake
alias bitbkae=bitbake
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'

alias grep='grep --color=auto -n'

alias ocaml='rlwrap ocaml'
alias ocamfind=ocamlfind
alias kpartition='partitionmanager'
alias gut=git

function svndiff() {
  svn diff $@ 2>&1 > /tmp/svndiff.diff
  vim /tmp/svndiff.diff
}
function evalopam() {
  eval `opam config env`
  ocamlc -version
  opam --version
}


if [ -x ~/.bashfnocvs ]; then
	source ~/.bashfnocvs
fi

