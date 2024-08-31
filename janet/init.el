;; The Lisp Spectrum Project

;; This is a minimal Emacs configuration to get you started with janet
;; You can use this configuration as an example for your own configuration or
;; you can use this configuration directly by running "emacs -Q -l init.el".

(package-initialize)

(load-theme 'modus-vivendi t)
(tool-bar-mode -1)

;; janet-mode or janet-ts-mode
(use-package janet-mode
  :ensure t)

;; janet repl
(unless (package-installed-p 'ajrepl)
  (package-vc-install "https://github.com/sogaiu/ajrepl.git"))
(use-package ajrepl
  :ensure t
  :hook ((janet-mode janet-ts-mode) . ajrepl-interaction-mode))

;; flycheck-janet
(unless (package-installed-p 'flycheck-janet)
  (package-vc-install "https://github.com/sogaiu/flycheck-janet.git"))
(use-package flycheck-janet
  :ensure t
  :init
  (global-flycheck-mode 1))

;; Paredit for structural editing
(use-package paredit
  :ensure t
  :hook ((janet-mode arepl-mode)
	 . paredit-mode)
  :config
  (defun +fix-paredit-@ ()
    (when (char-equal ?@ (char-before (- (point) 2)))
      (backward-char)
      (paredit-backward-delete)
      (forward-char)))
  :bind
  (:map paredit-mode-map
	("{" . (lambda ()
		 (interactive)
		 (paredit-open-curly)
		 (+fix-paredit-@)))
	("}" . paredit-close-curly)
	("[" . (lambda ()
		 (interactive)
		 (paredit-open-bracket)
		 (+fix-paredit-@)))))

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode arepl-mode)
	 . rainbow-delimiters-mode))

