; set default window size
(setq default-frame-alist (append (list
 	'(width  . 125)
 	'(height . 48)
) default-frame-alist))

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme/")

(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)

(scroll-bar-mode -1) ;; scroll bar
(tool-bar-mode -1)   ;; tool bar
(menu-bar-mode -1)   ;; menu bar


(setq file-name-coding-system 'utf-8)

(set-default-font "Inconsolata-15")
;(setq default-frame-alist '((font-backend . "xft")
;                            (font . "Inconsolata-14")
;                            (vertical-scroll-bars)
;                            (left-fringe . -1)
;                            (right-fringe . -1)
;                            (fullscreen . fullboth)
;                            (menu-bar-lines . 0)
;                            (tool-bar-lines . 0)
;                            ))

(setq inhibit-startup-message t)

(custom-set-variables
  '(column-number-mode t)
  '(default-input-method "russian-computer")
  '(display-time-mode t)
)

(show-paren-mode)

;;;;;;;;;;;;;; Whitespace config is not really tested for me
(require 'whitespace)
;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 80
  	whitespace-style '(tabs trailing lines-tail))

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
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1/dict")
(require 'auto-complete-config)
(ac-config-default)

(setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
;;;;;;;;;;;;;;;;;; tuareg mode for OCaml
(add-to-list 'load-path "~/.emacs.d/tuareg")
(require 'tuareg)
(load "tuareg-site-file.el")

(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
  	"Configuration of imenu for tuareg" t)
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist
        (append '(("\\.ml[ily]?$" . tuareg-mode)
	          ("\\.eliom[i]?$" . tuareg-mode)
	          ("\\.topml$" . tuareg-mode)
		) auto-mode-alist
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; use Merlin mode for OCaml
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'merlin)

(add-hook 'tuareg-mode-hook 'merlin-mode)
(setq merlin-use-auto-complete-mode t)
;(setq ac-start-auto nil)  ; to disable auto-complete

;;;;;;; ocp-indent
;;; include statements same as for merlin
; (setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'ocp-indent)
(define-key tuareg-mode-map (kbd "TAB") 'ocp-indent-line)



;;;;;;;; QML mode
; QML mode from http://www.emacswiki.org/emacs/download/qml-mode.el
; is only for emacs 24
; QML mode from https://github.com/emacsmirror/qml-mode/blob/master/qml-mode.el
(load "~/.emacs.d/qml-mode.el")
(add-to-list 'auto-mode-alist '("\\.qml" . qml-mode))

;;;;;;;;; Bitbake files
(setq auto-mode-alist (append '(("\\.bb" . conf-mode)
                                ("\\.bbclass" . conf-mode)
                                ("\\.inc" . conf-mode))
                                  auto-mode-alist))

;;;;;;;;;; Doc-mode is requred for ASCII doc-mode
; Also it can be useful for C codeing (I have not tested that yet)
(require 'doc-mode)
(add-hook 'c-mode-common-hook 'doc-mode)
;;; ASCIIDOC mode
; some useful fucntions for creating asciidoc documents (I don't enable them)
; https://github.com/metaperl/asciidoc-el/blob/master/asciidoc.adoc
(add-to-list 'auto-mode-alist '("\\.doc$" . doc-mode))
(autoload 'doc-mode "doc-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
(add-to-list 'auto-mode-alist '("\\.asciidoc$" . doc-mode))

(setq auto-mode-alist
        (cons '("Makefile\\.*" . makefile-mode) auto-mode-alist))


