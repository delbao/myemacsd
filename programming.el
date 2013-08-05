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

;; all programming modes settings
(add-hook 'prog-mode-hook 
    '(lambda()
      (turn-on-auto-fill) ; autofill mode
      (setq comment-auto-fill-only-comments t) ; only autofill comment
      (setq-default fill-column 80) ; global default fill column
      (setq-default indent-tabs-mode nil) ; prevent emacs default tab replacing spaces
    )
)

; c/c++ mode options, see gnu ccmode manual for detail
; passed to c-add-style, variable values in alist
(setq my-cc-style
  '('(c-basic-offset . ,tab-width) ;; keep consistent with tab-width 4
    ; cc mode default style is gnu except for Java and Awk, set others to linux
    (c-default-style . ((java-mode . "java") (awk-mode . "awk") (other . "linux"))))
)

;; N.B. php-mode indentation inherits cc-mode
(add-hook 'c-mode-common-hook
  '(lambda()
    ;; quickly find header/cpp matching
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)
    (setq cc-search-directories '("." "/usr/include/*" "/usr/local/include/*" "../../src/*" "../include/dht/*")) ; add * to include subdir
    ;; turn on auto-newline and hungry-delete-key
    (c-toggle-auto-hungry-state)
    (electric-pair-mode t) ; auto paren complete
    ;; call my function to set c/c++ mode default indentation style
    (c-add-style "my-style" my-cc-style t)
  )
)

;; cperl mode options, see cperl mode manual for detail
(add-hook 'cperl-mode-hook
  '(lambda ()
     (setq cperl-hairy 1) ;; Turns on most of the CPerlMode options
     ;; (cperl-auto-newline t)
     (setq cperl-auto-newline-after-colon t)
     (setq cperl-indent-level tab-width); keep cperl mode indent consistent w/
                                        ; tab-width
     (setq cperl-continued-statement-offset 0); continued statements don't indent
                                        ; further
     (setq cperl-indent-parens-as-block t); also indent parentheses as block
     (setq cperl-close-paren-offset -4); close parenthese don't indent
     (setq cperl-tab-always-indent t) ; tab indent in anywhere of the line
  )
)

;;;;;;;;;;;;; Section III Tagging ;;;;;;;;;;;;;;;;;;;;;;;;;;    

;;;;;;;;;;;;;;;;;;;;;;;;Etags;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; set etags table list
;;
;;(setq tags-table-list      
;;      '("~/svndev/"))



;; platform dependent setting
;; TO-DO make it a callback function or c-like macro

; gtags shortcut reminder
; M-. ggtags-find-tag
; M-n and M-p moves to next and previous match
; M-} and M-{ to next and previous file respectively.
; M-o toggles between full and abbreviated displays of file names.
; When you locate the right match, press RET to finish
; which hides the auxiliary window and exits navigation mode.
; You can resume the search using M-,. To abort the search press M-*.
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
