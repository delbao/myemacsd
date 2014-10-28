;;;;;; session management, paths ;;;;;;;;

(recentf-mode 1) ; keep a list of recently opened files

(setq make-backup-files nil) ; prevent createing temp files

;;;;;; desktop + bookmark+ for session management ;;;;;;
(require 'bookmark+)

;; use only one desktop
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")

;; COMMENT-OUT: we may reuse the desktop, shouldn't remove it
;; remove desktop after it's been read
;;(add-hook 'desktop-after-read-hook
;;	  '(lambda ()
;;	     ;; desktop-remove clears desktop-dirname
;;	     (setq desktop-dirname-tmp desktop-dirname)
;;	     (desktop-remove)
;;	     (setq desktop-dirname desktop-dirname-tmp)))

(defun saved-session ()
  (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))

;; use session-restore to restore the desktop manually
(defun session-restore ()
  "Restore a saved emacs session."
  (interactive)
  (if (saved-session)
      (desktop-read)
    (message "No desktop found.")))

;; use session-save to save the desktop manually
(defun session-save ()
  "Save an emacs session."
  (interactive)
  (if (saved-session)
      (if (y-or-n-p "Overwrite existing desktop? ")
	  (desktop-save-in-desktop-dir)
	(message "Session not saved."))
  (desktop-save-in-desktop-dir)))

;; ask user whether to restore desktop at start-up
;; this is only for default (emacs-desktop), other bookmarked session will not
;; trigger this
(add-hook 'after-init-hook
	  '(lambda ()
	     (if (saved-session)
		 (if (y-or-n-p "Restore desktop? ")
		     (session-restore)))))
;;;;;; END of desktop + bookmark+ for session management ;;;;;;
