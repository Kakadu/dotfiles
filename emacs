(add-to-list 'load-path (concat
   (replace-regexp-in-string "\n$" ""
      (shell-command-to-string "opam config var share"))
   "/emacs/site-lisp"))
(require 'ocp-indent)

