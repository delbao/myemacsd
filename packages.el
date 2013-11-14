;; package management work >= emacs 24
(when (> emacs-major-version 23)
  ;; add emacs package download repo
 (require 'package)
 ;; prevent emacs load packages again after init file, manually call
 ;; package-initialize 
 (setq package-enable-at-startup nil)
 (add-to-list 'package-archives
              '("melpa" . "http://melpa.milkbox.net/packages/")
              'APPEND)
 (add-to-list 'package-archives
              '("marmalade" . "http://marmalade-repo.org/packages/")
              'APPEND)
 ;; load all inistalled packages
 (package-initialize)
 (unless package-archive-contents (package-refresh-contents))

 ;; maintain required package list and automatic installation
 (defvar my-package-list '())
 (dolist (pkg my-package-list)
   (unless (package-installed-p pkg)
     (package-install pkg)))
)

 ;; should not manually load all paths in elpa, package-initialize or emacs 
 ;; automatical load will add them to load-path automatically

(setq load-path (append load-path (list "~/.emacs.d/")))
