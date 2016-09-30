execute pathogen#infect()
syntax on
colorscheme ron
filetype on

" bitbake recipes
au BufNewFile,BufRead *.bbappend,*.bbclass,*.bb,*.conf set filetype=conf
" OCaml stuff
au BufNewFile,BufRead *emacs     	set filetype=lisp
au BufNewFile,BufRead *.eliom		set filetype=ocaml
au BufNewFile,BufRead *.eliomi		set filetype=ocaml

" ocp-indent
"let g:ocp_indent_vimfile = system("opam config var share")
"let g:ocp_indent_vimfile = substitute(g:ocp_indent_vimfile, '[\r\n]*$', '', '')
"let g:ocp_indent_vimfile = g:ocp_indent_vimfile . "/vim/syntax/ocp-indent.vim"
"autocmd FileType ocaml exec ":source " . g:ocp_indent_vimfile
"set bg=light


" SeeTab: toggles between showing tabs and using standard listchars
fu! SeeTab()
  if !exists("g:SeeTabEnabled")
    let g:SeeTabEnabled = 1
    let g:SeeTab_list = &list
    let g:SeeTab_listchars = &listchars
    let regA = @a
    redir @a
    "hi SpecialKey
    redir END
    let g:SeeTabSpecialKey = @a
    let @a = regA
    "silent! hi SpecialKey guifg=black guibg=magenta ctermfg=black ctermbg=magenta
    set list
    set listchars=tab:\|\ 
  else
    let &list = g:SeeTab_list
    let &listchars = &listchars
    silent! exe "hi ".substitute(g:SeeTabSpecialKey,'xxx','','e')
    unlet g:SeeTabEnabled g:SeeTab_list g:SeeTab_listchars
  endif
endfunc
com! -nargs=0 SeeTab :call SeeTab()

SeeTab

