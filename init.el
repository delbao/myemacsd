;; base init file to include all other config files
;; put common short config here. Can refactor later if the section becomes large
;; all user defined config files in ~/.emacs.d/
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;; section 1 package management
;; add emacs package download repo 
(when (> emacs-major-version 23)
 (require 'package)
 (package-initialize)
 (add-to-list 'package-archives
              '("melpa" . "http://melpa.milkbox.net/packages/")
              'APPEND))

;; add ~/.emacs.d/elpa and its subdir to load path, it's appended to the head to override later ones
(let ((default-directory (expand-file-name "elpa/" user-init-dir)))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path))) ;; shadow
           (append 
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(load-user-file "appearance.el")
;; define path variables
;; (load-user-file "paths.el")
;; define global keys (specific key map is defined in its own setting but listed in comment for reference)
(load-user-file "keys.el")
;; common programming settings, e.g., tags
(load-user-file "programming.el")
;; no time to refactor yet
(load-user-file "cluttered.el")
