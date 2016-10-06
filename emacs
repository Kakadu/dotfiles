(setq inhibit-startup-message t)
; set default window size

;(add-to-list 'load-path "~/.emacs.d/")

(scroll-bar-mode -1) ;; scroll bar
(tool-bar-mode -1)   ;; tool bar
(menu-bar-mode -1)   ;; menu bar
(fset 'yes-or-no-p 'y-or-n-p) ; use y or n instead of yes or not
(define-key menu-bar-tools-menu [games] nil) ; disable games menu
; disabling overwrite mode
(define-key global-map [(insert)] nil)

;; Create a backup file
(setq backup-by-copying t ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.emacs.d/backup/")) ; don't litter my fs tree
      kept-new-versions 4 ; keep 4 last backups
      kept-old-versions 0 ; don't keep first backups
      delete-old-versions t ; delete intermediate backup files
      version-control t) ; use versioned backups

;; Enable mouse wheel
(mouse-wheel-mode 1)
(setq mouse-wheel-scroll-amount '(1)    ; mouse scroll one line at a time
      mouse-wheel-progressive-speed nil ; don't accelerate scrolling
      mouse-wheel-follow-mouse t        ; scroll window under mouse
      setscroll-step 1                  ; keyboard scroll one line at a time
      scroll-conservatively 10000       ; scroll one line at a time if point moves off-screen
      scroll-preserve-screen-position t ; keep point at the same screen position
      scroll-margin 0                   ; set scroll margin
      auto-window-vscroll nil           ; don't adjust window-vscroll to view tall lines
)

(setq x-select-enable-clipboard t) ; cut and paste to the X clipboard

(setq file-name-coding-system 'utf-8)

; geometry hacks
  ;; (setq initial-frame-alist
  ;;        '((top . 1) (left . 0)
  ;;          (width . 135) (height . 53)
  ;;          ) )
;; (setq default-frame-alist (append (list
;;   '(width  . 103) '(height . 35)
;; ) default-frame-alist) )
(setq default-frame-alist (append (list
  '(width  . 113) '(height . 35)
) default-frame-alist) )

(when (string= system-name "lemonad")
  ;(set-default-font "Monaco-14")
;  (set-default-font "Dejavu-Sans-Mono-Book-14")
  (set-default-font "Ubuntu-14")
  (setq default-frame-alist
         '((top . 1) (left . 0)
           (width . 189) (height . 53)
           ) )
 )

(custom-set-variables
  '(column-number-mode t)
  '(default-input-method "russian-computer")
  '(display-time-mode t)
  '(display-time-interval 10)                  ; update evetry 10 seconds
  '(display-time-24hr-format t)                ; time format
  '(display-time-default-load-average nil)     ; CPU loading

)

(show-paren-mode)

;;;;;;;;;;;;;; Color theme
(when (= emacs-major-version 24)
  (message "emacs version 24")
  ; emacs 24 color theme from: https://github.com/emacs-jp/replace-colorthemes
  (load-theme 'wheatgrass t)
  ;(enable-theme 'dark-laptop)
)
(when (= emacs-major-version 23)
  ;(message "emacs version 23")
  (add-to-list 'load-path "~/.emacs.d/color-theme-latest/")
  (require 'color-theme)
  (color-theme-initialize)
  (color-theme-dark-laptop)
)


;;;;;;;;;;;;;; Whitespace config is not really tested for me
(setq-default indent-tabs-mode nil) ; never use tab characters for indentation
(setq tab-width 2                   ; set tab-width
      c-default-style "stroustrup"  ; indent style in CC mode
      c-basic-offset 4
      c-indent-level 4
      js-indent-level 2             ; indentation level in JS mode
      css-indent-offset 2           ; indentation level in CSS mode
)
(require 'whitespace)
;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 80
  	whitespace-style '(tabs trailing lines-tail))

;; TODO: maybe use hungry-delete mode?
;; https://github.com/nflath/hungry-delete

;; face for long lines' tails
(set-face-attribute 'whitespace-line nil
                	:background "red1"
                	:foreground "yellow"
                	:weight 'bold)

;; face for Tabs
(set-face-attribute 'whitespace-tab nil
                	:background "red1"
                	:foreground "yellow"
                	:weight 'bold)

; kill *scratch* buffer on start
(defun my-startup-hook () (kill-buffer "*scratch*"))
(add-hook 'emacs-startup-hook 'my-startup-hook)
; remove trailing whitespaces before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
; C-Backspace removes word
(defun delete-word (arg)
  "Delete characters forward until encountering the end With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  "Delete characters backward  the end of a word. With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))
(global-set-key (read-kbd-macro "<C-backspace>") 'backward-delete-word)

; share system buffer
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;;;;;;;;;;;;;;;;;; Autocompelte mode
; in emacs 24 it is available out-of-box. But I'm using emacs 23 at the moment
(when (= emacs-major-version 23)
  ;(message "emacs version 23")
  (add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
  (require 'auto-complete)
  ;(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1/dict")
  ;(require 'auto-complete-config)
  ;(ac-config-default)
)

(defun opam-env ()
  (interactive nil)
  (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
    (setenv (car var) (cadr var))))

(opam-env)

(setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
;;;;;;;;;;;;;;;;;; tuareg mode for OCaml
(add-to-list 'load-path "~/.emacs.d/tuareg-latest")
(if (locate-library "tuareg")
  (progn
    (require 'tuareg)
    (load "tuareg-site-file.el")
    ; I like orange keywords more
    (set-face-attribute 'tuareg-font-lock-governing-face nil :foreground "orange")
    (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
    (setq auto-mode-alist
          (append '(("\\.ml[ily4]?$" . tuareg-mode)
                    ("\\.eliom[i]?$" . tuareg-mode)
                    ("\\.topml$" . tuareg-mode)
                    ) auto-mode-alist
          )
    )
  )
  (message "can't find tuareg-mode")
)

;;;;;;;; QML mode
; QML mode from http://www.emacswiki.org/emacs/download/qml-mode.el
; is only for emacs 24
; QML mode from https://github.com/emacsmirror/qml-mode/blob/master/qml-mode.el
;(load "~/.emacs.d/qml-mode.el")
;(add-to-list 'auto-mode-alist '("\\.qml" . qml-mode))

; cypher (neo4j) mode
;(add-to-list 'load-path "~/.emacs.d/tuareg-latest")
;(if (locate-library "cypher-mode")
 ; (progn'
;    (require 'cypher-mode)
;    (add-to-list 'auto-mode-alist '("\\.cfr" . cypher-mode) )
;  )
;  (message "Loading cypher-mode skipped")
;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; use Merlin mode for OCaml
(defun string/starts-with (s begins)
  "Return non-nil if string S starts with BEGINS."
  (cond ((>= (length s) (length begins))
         (string-equal (substring s 0 (length begins)) begins))
         (t nil)))
(setq ocaml-version (shell-command-to-string "ocamlc -version"))
(message ocaml-version)
        ;(message "In this version of OCaml merlin is not broken")
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(if (locate-library "merlin")
  (require 'merlin)
  (message "merlin is not available")
)


(add-hook 'tuareg-mode-hook 'merlin-mode)
;(setq merlin-use-auto-complete-mode nil)      ; disables auto-complete
(setq merlin-use-auto-complete-mode 'easy)
;(require 'company-mode)            ; not tryed yet
;(setq ac-start-auto nil)  ; to disable auto-complete

;;;;;;; ocp-indent
;;; include statements same as for merlin
; (setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(if (locate-library "ocp-indent")
  (progn
    (require 'ocp-indent)
    (define-key tuareg-mode-map (kbd "TAB") 'ocp-indent-line))
  (message "ocp-indent is not available")
)

;;;;;;;;; Bitbake files
(setq auto-mode-alist (append '(("\\.bb" . conf-mode)
                                ("\\.bbclass" . conf-mode)
                                ("\\.inc" . conf-mode))
                                  auto-mode-alist))

;;;;;;;;;; Doc-mode is requred for ASCII doc-mode
; Also it can be useful for C codeing (I have not tested that yet)
(if (locate-library "doc-mode")
  (require 'doc-mode)
  (message "DOC-mode is not available; not configuring")
)

;(add-hook 'c-mode-common-hook 'doc-mode)
;;; ASCIIDOC mode
; some useful fucntions for creating asciidoc documents (I don't enable them)
; https://github.com/metaperl/asciidoc-el/blob/master/asciidoc.adoc
(add-to-list 'auto-mode-alist '("\\.doc$" . doc-mode))
(autoload 'doc-mode "doc-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
(add-to-list 'auto-mode-alist '("\\.asciidoc$" . doc-mode))

(add-to-list 'auto-mode-alist '("Makefile\\.*" . makefile-mode))
(add-to-list 'auto-mode-alist '("emacs\\.*" . lisp-mode))

; disabling overwrite mode
(define-key global-map [(insert)] nil)

; ProofGeneral
;(if (file-exists-p "~/.emacs.d/ProofGeneral")
; (load-file "~/.emacs.d/ProofGeneral/generic/proof-site.el")
;)

;(if (file-exists-p "~/.emacs.d/haskell-mode")
;    (add-to-list 'load-path "~/.emacs.d/haskell-mode/")
;    (message "haskell-mode not installed")
;)
;(if (locate-library "haskell-mode")
;  (progn'
;    (require 'haskell-mode-autoloads)
;    (add-to-list 'Info-default-directory-list "~/.emacs.d/haskell-mode/"))
;  (message "can't load haskell mode")
;)



; setting custom font face for keywords (like `if') in tuareg
(set-face-attribute 'font-lock-keyword-face nil
 :background "black"
 :foreground "orange"
 :weight     'bold
; :family "Monaco-15"
)

(global-set-key (kbd "M-`") 'other-frame)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))))

(load "~/.opam/4.02.3/share/emacs/site-lisp/ocp-indent.el")

(add-hook 'c-mode-common-hook
          (lambda () (define-key c-mode-base-map (kbd "C-c C-c") 'compile)))



