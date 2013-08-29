;; hotkeys

;;;;;;;;;;;;GNU GLOBAL see programming.el section 2;;;;;;;;;;;;;;;
;; (global-set-key "\M-." 'gtags-find-tag) ;; M-. finds tag
;; (global-set-key [(control meta .)] 'gtags-find-rtag) ;; C-M-. find all references of tag
;; (global-set-key [(control meta ,)] 'gtags-find-symbol) ;; C-M-, find all usages of symbol

;; speed bar
(global-set-key [(f4)] 'speedbar-get-focus)

;; recentf
(global-set-key [(control f2)] 'recentf-open-files)

;; fixing osx gnu emacs hotkeys
(when (string-match "darwin" system-configuration)
  (message "customizing GNU Emacs for OSX")
  (define-key global-map [home] 'beginning-of-line)
  (define-key global-map [end] 'end-of-line)
)
