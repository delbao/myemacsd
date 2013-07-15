;;;;;;;;;;;; Section I common features ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; font-lock mode (syntax hightlight) is by default turned on in each major
;; programming mode
;; (global-font-lock-mode t)

;; programming mode file association for non default ones
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; hooked .h to c++-mode instead of c-mode 
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))

;; cperl-mode replaces perl-mode
(defalias 'perl-mode 'cperl-mode)

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

;; N.B. php-mode indentation inherits cc-mode
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

;; cperl mode options, see cperl mode manual for detail
(add-hook 'cperl-mode-hook
  '(lambda ()
    (cperl-hairy 1) ;; Turns on most of the CPerlMode options
    (cperl-toggle-auto-newline)
  )
)

;;;;;;;;;;;;; Section III Tagging ;;;;;;;;;;;;;;;;;;;;;;;;;;    

;;;;;;;;;;;;;;;;;;;;;;;;Etags;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; set etags table list
;;
;;(setq tags-table-list      
;;      '("~/svndev/"))


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
 ((string-match "nt" system-configuration) ;; XP=nt5 7=nt6
  (message "customizing GNU Emacs for Win NT")
  )
 ((string-match "darwin" system-configuration)
  (message "customizing GNU Emacs for OSX")
    (add-hook 'c-mode-common-hook
        '(lambda() (ggtags-mode 1)))
  )
 )

;;(setq gtags-select-buffer-single nil
;;       gtags-suggested-key-mapping t)

;;;;;;;;;;;;; Section IV IDE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; enable cedet submodes
(setq semantic-default-submodes '(global-semanticdb-minor-mode))

(semantic-mode)

;; let semanticdb take gtags for these modes
;; defined in semantic/db-global
(semanticdb-enable-gnu-global-databases 'c++-mode)
(semanticdb-enable-gnu-global-databases 'php-mode)

;; let speedbar work with semantic
(add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb)))

;; Emacs Code Browser (ECB)
;; (require 'ecb)
;; (setq ecb-auto-activate t)
;; show-or-hide only takes effect after ecb is activated
;; (setq ecb-major-modes-show-or-hide '((c-mode php-mode) fundamental-mode lisp-interaction-mode))
;; (setq ecb-add-path-for-not-matching-files '(nil))

;; Due to tramp support issues, disable ECB, use speedbar for code browsing
;; Speedbar 
