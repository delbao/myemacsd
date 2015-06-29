;; hotkeys

(global-set-key [f12] 'compile)

;; default goto-line key M-g-g is slower to type
(global-set-key "\C-l" 'goto-line)

;; windmove
(windmove-default-keybindings 'meta) ;; windmove cua mode default binding meta, 
                                     ;; the original default is shift+arrow
                                     ;; which is bind to (save-excursion) lection extension in emacs

;; comment out below so that shift+arrow doesn't kick in
;; (when (fboundp 'windmove-default-keybindings)
;;      (windmove-default-keybindings))

;; speed bar
(global-set-key [(f4)] 'speedbar-get-focus) ;; this also invoke speedbar

;; recentf
(global-set-key [(control f2)] 'recentf-open-files)

;; fixing osx gnu emacs hotkeys
(when (string-match "darwin" system-configuration)
  (message "customizing GNU Emacs for OSX")
  (define-key global-map [home] 'beginning-of-line)
  (define-key global-map [end] 'end-of-line)
)

;; buffer-move
(global-set-key (kbd "<C-M-up>")     'buf-move-up)
(global-set-key (kbd "<C-M-down>")   'buf-move-down)
(global-set-key (kbd "<C-M-left>")   'buf-move-left)
(global-set-key (kbd "<C-M-right>")  'buf-move-right)

;; tabbar
(global-set-key (kbd "C-S-p") 'tabbar-backward-group)
(global-set-key (kbd "C-S-n") 'tabbar-forward-group)
(global-set-key (kbd "C-<") 'tabbar-backward)
(global-set-key (kbd "C->") 'tabbar-forward)

;; ff-find-other-file
(add-hook 'c-mode-common-hook
          '(lambda()  
             ;; quickly find header/cpp matching
             (local-set-key  (kbd "C-c o") 'ff-find-other-file)
             (local-set-key  (kbd "C-c 4 o") 'ff-find-other-file-in-other-window)
             (setq cc-search-directories '("." "/usr/include/*" "/usr/local/include/*" "../../src/*" "../include/dht/*")) ; add * to include subdir)
             )
)

(add-hook 'prog-mode-hook
          '(lambda()
             (local-set-key "\C-cj" 'semantic-ia-fast-jump)
             (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
             )
)

(global-set-key (kbd "M-s o") 'occur-symbol-at-point)
