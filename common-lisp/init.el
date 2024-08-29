;; The Lisp Spectrum Project

;; This is a minimal Emacs configuration to get you started with common lisp
;; You can use this configuration as an example for your own configuration or
;; you can use this configuration directly by running "emacs -Q -l init.el".

(package-initialize)

(load-theme 'modus-vivendi t)
(tool-bar-mode -1)

;; set your inferior-lisp command here which is basically your implementation
;; executable. If you are using Roswell change this to "ros run" to run Roswell
;; with the default implementation.
(setq inferior-lisp-program "sbcl")

;; Choose either 'sly or 'slime
(setq lisp-repl 'slime)

;; Sly and Slime have conflicting  configurations.
;; That's why when we install one we have to uninstall the other
(cond
 ;; Use Sly for Interaction with the REPL
 ((eq lisp-repl 'sly)
  (message "Removing SLIME and installing Sly")
  (remove-hook 'lisp-mode-hook 'slime-lisp-mode-hook)
  (use-package sly :ensure t))
 ;; Use Slime for Interaction with the REPL
 ((eq lisp-repl 'slime)
  (message "Removing Sly and installing SLIME")
  (remove-hook 'lisp-mode-hook 'sly-editing-mode)
  (use-package slime :ensure t)
  (use-package slime-repl-ansi-color
    :ensure t
    :hook (slime-repl-mode . (lambda () (slime-repl-ansi-color-mode 1))))
  ))

;; Paredit for structural editing
(use-package paredit
  :ensure t
  :hook ((lisp-mode
	  emacs-lisp-mode
	  lisp-interaction-mode
	  slime-repl-mode
	  sly-repl-mode)
	 . paredit-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode
	  sly-repl-mode
	  slime-repl-mode)
	 . rainbow-delimiters-mode))

;; Start Scratch buffer in Lisp mode
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (with-current-buffer "*scratch*"
	      (lisp-mode))))
