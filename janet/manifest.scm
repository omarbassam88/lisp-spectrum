;; What follows is a "manifest" created by the Lisp Spectrum project to help you
;; get started with Common Lisp and all the packages you need. You can use this
;; file using this command: "guix shell -m manifest.scm".

(use-modules (guix packages)
	     (guix licenses)
	     (guix git-download)
             (gnu packages lisp)
             (gnu packages emacs)
	     (guix build-system trivial)
	     (guix gexp)) 


(define jpm
  (package
   (name "jpm")
   (version "1.1.0")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/janet-lang/jpm.git")
		  (commit "v1.1.0")))
	    (sha256 (base32 "05rdxigmiy7vf93s16a8n2029lq33073jccz1rjl4iisxj6piw4l"))))
   (build-system trivial-build-system)
   (arguments
    (list
     #:modules `((guix build utils))
     #:builder #~(begin
		   (use-modules (guix build utils))
		   (mkdir %output)
		   (for-each (lambda (dir) (mkdir (string-append %output "/" dir)))
			     '("bin" "lib" "share" "share/man" "lib/janet" "lib/janet/jpm" "share/man/man1"))
		   (copy-recursively (assoc-ref %build-inputs "source") "source")
		   (chdir "source")
		   (substitute* "configs/linux_config.janet"
				(("auto-shebang true") "auto-shebang false"))
		   (substitute* "configs/linux_config.janet"
				(("/usr/local") %output))
		   (substitute* "jpm/shutil.janet"
				(("cp") (string-append #$coreutils "/bin/cp")))
		   (substitute* "jpm/declare.janet"
				(("chmod") (string-append #$coreutils "/bin/chmod")))
		   ;; ENV Variables needed for build
		   (setenv "PREFIX" %output)
		   (setenv "JANET_PREFIX" %output)
		   (setenv "JANET_LIBPATH" (string-append %output "/lib/janet"))
		   (setenv "JANET_MODPATH" (string-append %output "/lib/janet"))
		   ;; Running the build command
		   (system* (string-append #$janet "/bin/janet") "bootstrap.janet" "configs/linux_config.janet")
		   ;; Required for to find the janet headers
		   (copy-recursively (string-append #$janet "/include/janet") (string-append %output "/include/janet"))
		   (copy-recursively (string-append #$janet "/lib") (string-append %output "/lib")))))
   (inputs (list janet coreutils))
   (home-page "https://janet-lang.org/")
   (synopsis "Janet Project Manager for the Janet programming language")
   (description "JPM is the Janet Project Manager tool. It is for automating builds and downloading dependencies of Janet projects. This project is a port of the original jpm tool (which started as a single file script) to add more functionality, clean up code, make more portable and configurable, and refactor jpm into independent, reusable pieces that can be imported as normal Janet modules.")
   (license expat)))

;; Change to your editor of choice To force guix shell to read
;; environment variables run "guix shell -m manifest.scm --rebuild-cache"
(setenv "EDITOR" "emacs")

(packages->manifest
 (append
  (list
   ;; Emacs is the de facto standard to working with Lisp(s)
   emacs

   janet
   
   jpm)))
