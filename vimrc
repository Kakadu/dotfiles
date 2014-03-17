syntax on
colorscheme ron
filetype on

" bitbake recipes
au BufNewFile,BufRead *.bbappend 	set filetype=conf
" OCaml stuff
au BufNewFile,BufRead *emacs     	set filetype=lisp
au BufNewFile,BufRead *.eliom		set filetype=ocaml
au BufNewFile,BufRead *.eliomi		set filetype=ocaml

" ocp-indent
let g:ocp_indent_vimfile = system("opam config var share")
let g:ocp_indent_vimfile = substitute(g:ocp_indent_vimfile, '[\r\n]*$', '', '')
let g:ocp_indent_vimfile = g:ocp_indent_vimfile . "/vim/syntax/ocp-indent.vim"
autocmd FileType ocaml exec ":source " . g:ocp_indent_vimfile

