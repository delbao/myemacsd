;;;;;;;;;;;;;;;;;;;;;;;;Etags;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; set etags table list
;;
;;(setq tags-table-list      
;;      '("~/svndev/"))

;;;;;;;;;;;;;;;;;;;;;;; Section 2 GNU Global Tagging;;;;;;;;;;;;;;;;;;;;;;;;;;    
;; to use global from Emacs, you need to load the `gtags.el' and execute gtags-mode function in it.
;; you need to add it to load-path. for `gtags.el'file.

;; platform dependent setting
;; to-do make it a callback function or c-like macro

(cond 
 ((string-match "linux" system-configuration)
  (message "customizing GNU Emacs for Linux")
    ; anything special about Linux begins here 

    ; and ends here
  )
 ((string-match "nt6" system-configuration)
  (message "customizing GNU Emacs for Win NT")
    ; anything special about Windows begins here 

    ; and ends here
  )
    ; anything special for the OS ends here
 ((string-match "darwin" system-configuration)
  (message "customizing GNU Emacs for OSX")
    ; anything special about Windows begins here 
    (add-hook 'c-mode-common-hook          ;; unlike setq, don't forget quote (') before c++-mode-hook
        '(lambda() (gtags-mode 1)   ;; get into gtags-mode whenever you get into c++-mode
            (setq gtags-global-command "/opt/local/bin/global")))
    ; and ends here
  )

 )

(message system-configuration)

        ; all the common things for different OS start here


        ; and end here

;; hotkeys
(global-set-key "\M-." 'gtags-find-tag) ;; M-. finds tag
(global-set-key [(control meta .)] 'gtags-find-rtag) ;; C-M-. find all references of tag
;;(global-set-key [(control meta ,)] 'gtags-find-symbol) ;; C-M-, find all usages of symbol

;;(setq gtags-select-buffer-single nil
;;       gtags-suggested-key-mapping t)

;; programming mode file association for non default ones
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))
