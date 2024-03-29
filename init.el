;; base init file to include all other config files
;; put common short config here. Can refactor later if the section becomes large
;; all user defined config files in ~/.emacs.d/my/
(defconst user-init-dir "~/.emacs.d/my/")

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "packages.el")

;; SECTION II paths
(cond
 ((string-match "darwin" system-configuration)
  (message "customizing paths for OSX")
  ;; if Emacs.app is run, get PATH from terminal
  (if (not (getenv "TERM_PROGRAM"))
      (let ((path (shell-command-to-string
                   "source ~/.bash_profile > /dev/null; printf $PATH")))
        (setenv "PATH" path)))
  (setq exec-path (split-string (getenv "PATH") ":"))
 )
)

(load-user-file "appearance.el")
(load-user-file "editing.el")
(load-user-file "session.el")
;; define path variables
;; (load-user-file "paths.el")
;; define global keys (specific key map is defined in its own setting but listed in comment for reference)
;; common programming settings, e.g., tags
(load-user-file "programming.el")
(load-user-file "search.el")
;; no time to refactor yet
(load-user-file "cluttered.el")
(load-user-file "keys.el")
