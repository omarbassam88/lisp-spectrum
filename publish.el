;; The Lisp Spectrum project website
;; To publish the website run the command "emacs -Q -l publish.el"
;; You can then serve the website from the created public folder

(require 'package)

;; Download packages in a local folder
(setq package-user-dir (expand-file-name "./.packages"))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

(defun rename-project-files (from-regex to)
  (dolist (from-file (directory-files-recursively "./public" from-regex))
    (let ((to-file-name (replace-regexp-in-string from-regex to 
						  from-file t)))
      (message (format "renaming %s to %s" from-file to-file-name))
      (rename-file from-file to-file-name t))))


(setq org-publish-project-alist
      (list
       (list
	"lisp-spectrum"
	:base-directory "."
	:base-extension "org"
	:publishing-directory "./public"
	:publishing-function 'org-html-publish-to-html
	:recursive t
	:with-toc nil
	:with-author nil
	:with-creator nil
	:with-date nil
	:with-timestamps nil
	:time-stamp-file nil
	:section-numbers nil
	;; function to be called after publishing the project
	:completion-function (lambda (_)
			       (rename-project-files "README" "index")
			       (message "Project is now published")))))

(defun publish ()
  (org-publish-all t))

(publish)
