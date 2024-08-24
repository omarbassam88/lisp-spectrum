;; What follows is a "manifest" created by the Lisp Spectrum project to help you
;; get started with Common Lisp and all the packages you need. You can use this
;; file using this command: "guix shell -m manifest.scm".

(use-modules (guix packages)
             (gnu packages lisp)
             (gnu packages emacs)
             (gnu packages java)      ;; for ABCL
             (gnu packages tls)       ;; for openssl
             (gnu packages libevent)) ;; for libev

;; To set LD_LIBRARY_PATH Environment variable
(define ld-library-path (search-path-specification
                         (variable "LD_LIBRARY_PATH")
                         (separator ":")
                         (files (list "lib"))))

(define (expose-library-path p)
  "A helper function to set the LD_LIBRARY_PATH environment variable for installed
libraries in shell"
  (package
   (inherit p)
   (native-search-paths (list ld-library-path))))

;; Change to your editor of choice To force guix shell to read
;; environment variables run "guix shell -m manifest.scm --rebuild-cache"
(setenv "EDITOR" "emacs")

(packages->manifest
 (append
  (list
   ;; Emacs is the de facto standard to working with Lisp(s)
   emacs

   ;; Roswell (Recommended)
   ;; Implementations and Dependency management
   roswell

   ;; Implementations
   sbcl ;; Steel Bank Common Lisp
   abcl ;; Armed Bear Common Lisp
   ccl  ;; Clozure Common Lisp
   ecl  ;; Embedded Common Lisp
   )
  (map expose-library-path
       (list
        libev   ;; for WOO
        openssl ;; for Hunchentoot
        ))))
