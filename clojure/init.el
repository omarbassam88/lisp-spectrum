;; The Lisp Spectrum Project

;; This is a minimal Emacs configuration to get you started with common lisp
;; You can use this configuration as an example for your own configuration or
;; you can use this configuration directly by running "emacs -Q -l init.el".

(package-initialize)

(load-theme 'modus-vivendi t)
(tool-bar-mode -1)

;; clojure-mode a major mode for .clj(s) files
(use-package clojure-mode
  :ensure t)

;; REPL interaction for clojure
(use-package cider
  :ensure t)

;; powerful refactoring functionality
(use-package clj-refactor
  :ensure t)

;; Paredit for structural editing
(use-package paredit
  :ensure t
  :hook ((clojure-mode
	  cider-repl-mode)
	 . paredit-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode
	  cider-repl-mode)
	 . rainbow-delimiters-mode))

