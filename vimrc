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

set tabstop=2
set shiftwidth=2
" Show extra whitespace
set list
" set hot key to show/hide nonprinted characters somehow
"nmap <leader>l :set list!<CR>
set listchars=tab:▸\ 
"set listchars=tab:▸\ ,eol:¬

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction

let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## fa4d6ec6f736f1087a381504237ffe86 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/kakadu/.opam/4.02.3/share/vim/syntax/ocp-indent.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line


