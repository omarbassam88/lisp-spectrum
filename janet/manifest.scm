;; What follows is a "manifest" created by the Lisp Spectrum project to help you
;; get started with Common Lisp and all the packages you need. You can use this
;; file using this command: "guix shell -m manifest.scm".

(use-modules (guix packages)
             (gnu packages emacs)
             (gnu packages lisp))

;; Change to your editor of choice To force guix shell to read
;; environment variables run "guix shell -m manifest.scm --rebuild-cache"
(setenv "EDITOR" "emacs")

(packages->manifest
 (append
  (list emacs ;; Emacs is the de facto standard to working with Lisp(s)
	janet
	jpm ;; Janet Project Manager
	)))
