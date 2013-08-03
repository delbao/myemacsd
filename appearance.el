;; load 'solarized-dark' theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)

;; start up positions and size
(cond 
 ((string-match "linux" system-configuration)
    (message "customizing GNU Emacs for Linux")
    )
 ((string-match "nt6" system-configuration)
    (message "customizing GNU Emacs for Win NT")
    (modify-frame-parameters nil '((width . 315) (height . 38) (top . 0) (left . -1235)))
    (add-hook 'window-setup-hook ; due to init order
        '(lambda ()
           (split-window-horizontally 64)
           (split-window-horizontally 22)
           )
        )
 )
 ((string-match "darwin" system-configuration)
    (message "customizing GNU Emacs for OSX")
    ;; nil as frame to change init frame (selected-frame) size, can also use (make-frame) to create new frame
    (modify-frame-parameters nil '((width . 360) (height . 62) (top + -1024) (left . 2055))) 
  )
 )
