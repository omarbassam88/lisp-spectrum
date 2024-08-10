;; The Lisp Spectrum Project

;; This is a minimal Emacs configuration to get you started with guile
;; You can use this configuration as an example for your own configuration or
;; you can use this configuration directly by running "emacs -Q -l init.el".

(package-initialize)

(load-theme 'modus-vivendi t)
(tool-bar-mode -1)

(use-package geiser-guile
  :ensure t)

;; Paredit for structural editing
(use-package paredit
  :ensure t
  :hook ((scheme-mode
	  geiser-repl-mode)
	 . paredit-mode)
  :bind
  (:map paredit-mode-map
   ;; allow  using of "RET" normally in geiser
   ("RET" . nil)))

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode
	  geiser-repl-mode)
	 . rainbow-delimiters-mode))

