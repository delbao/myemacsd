;;;;;;;;;;;;;;;;;;;;;;;;Etags;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; set etags table list
;;
;;(setq tags-table-list      
;;      '("~/svndev/"))

;; font-lock mode (syntax hightlight) is by default turned on in each major
;; programming mode
;; (global-font-lock-mode t)

;;;;;;;;;;;;; Section II hooked features ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; b/c multiple modes can share same features, make this feature-centered
;; instead of mode-centered

;; autofill mode enabled automatically for all programming modes and only for comments
(add-hook 'prog-mode-hook 'turn-on-auto-fill)
(setq comment-auto-fill-only-comments t)
(setq-default fill-column 80)

;; c/c++ mode options, see gnu ccmode manual for detail

;; passed to c-add-style, variable values in alist
(setq my-cc-style
  '((c-basic-offset . 4)
    ;; cc mode default style is gnu except for Java and Awk, set others to linux
    (c-default-style . ((java-mode . "java") (awk-mode . "awk") (other . "linux")))
    (cc-search-directories . (("." "/usr/include" "/usr/local/include/*" "../../src" "../include/dht/"))))
)

(add-hook 'c-mode-common-hook
  (lambda() 
    ;; quickly find header/cpp matching
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)
    ;; turn on auto-newline and hungry-delete-key
    (c-toggle-auto-state)
    ;; call my function to set c/c++ mode default indentation style
    (c-add-style "my-style" my-cc-style t)
  )
)

;;;;;;;;;;;;;;;;;;;;;;; Section 2 GNU Global Tagging;;;;;;;;;;;;;;;;;;;;;;;;;;    
;; to use global from Emacs, you need to load the `gtags.el' and execute gtags-mode function in it.
;; you need to add it to load-path. for `gtags.el'file.

;; platform dependent setting
;; TO-DO make it a callback function or c-like macro

(cond 
 ((string-match "linux" system-configuration)
  (message "customizing GNU Emacs for Linux")
    ; anything special about Linux begins here 

    ; and ends here
  )
 ((string-match "nt6" system-configuration)
  (message "customizing GNU Emacs for Win NT")
  )
 ((string-match "darwin" system-configuration)
  (message "customizing GNU Emacs for OSX")
    (add-hook 'c-mode-common-hook          ;; unlike setq, don't forget quote (') before c++-mode-hook
        '(lambda() (ggtags-mode 1)))   ;; get into gtags-mode whenever you get into c++-mode
  )
 )

(message system-configuration)

        ; all the common things for different OS start here


        ; and end here

;;(setq gtags-select-buffer-single nil
;;       gtags-suggested-key-mapping t)

;; programming mode file association for non default ones

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; hooked .h to c++-mode instead of c-mode 
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))
