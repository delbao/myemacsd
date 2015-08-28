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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(bmkp-last-as-first-bookmark-file "/Users/dbao/.emacs.d/bookmarks")
 '(compilation-scroll-output t)
 '(cua-mode t nil (cua-base))
 '(gdb-show-main t)
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(iswitchb-mode t)
 '(safe-local-variable-values
   (quote
    ((c-file-style . GNU)
     (Indent . Inktomi4)
     (c-file-offsets
      (substatement-open . 0)))))
 '(tramp-default-host "sportspot-dl-vm1.corp.yahoo.com")
 '(tramp-default-method "plink")
 '(tramp-default-proxies-alist
   (quote
    (("\\\\yahoo\\\\.com\\\\'" "nil" "/tunnel:7.194.123.149#808"))))
 '(tramp-default-user "dbao")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-separator "."))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tabbar-button ((t (:inherit tabbar-default :foreground "dark red"))))
 '(tabbar-button-highlight ((t (:inherit tabbar-default))))
 '(tabbar-default ((t (:inherit variable-pitch :background "#959A79" :foreground "black" :weight bold))))
 '(tabbar-highlight ((t (:underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#95CA59"))))
 '(tabbar-separator ((t (:inherit tabbar-default :background "#95CA59"))))
 '(tabbar-unselected ((t (:inherit tabbar-default)))))
