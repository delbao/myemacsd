;;;;
;;;;;;;;;;;;;;;;;;;;;;;;; Section I common features ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;; font-lock mode (syntax hightlight) is by default turned on in each major
;; programming mode
;; (global-font-lock-mode t)

;; generated autoload file powershell-mode-autoload not containing autoload cmd
(autoload 'powershell-mode "powershell-mode" "Mode PowerShell" t)

;; programming mode file association for non default ones
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; hooked .h to c++-mode instead of c-mode 
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.ps[12]?$" . powershell-mode))

;; cperl-mode replaces perl-mode
(defalias 'perl-mode 'cperl-mode)

;;
;;;;;;;;;;;;; Section II hooked features ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; b/c multiple modes can share same features, make this feature-centered
;; instead of mode-centered

;; all programming modes settings
(add-hook 'prog-mode-hook 
    '(lambda()
      (turn-on-auto-fill) ; autofill mode
      (setq comment-auto-fill-only-comments t) ; only autofill comment
      (setq-default fill-column 80) ; global default fill column
      (setq-default indent-tabs-mode nil) ; prevent emacs default tab replacing
                                          ; spaces
      (which-func-mode)  ; turn on which-func-mode
      (smart-operator-mode)   ; turn on smart-operator-mode
      (hs-minor-mode)
      (subword-mode) ; camel case move/ops M+-> or M+<-
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
    ;; turn on auto-newline and hungry-delete-key
    (c-toggle-auto-hungry-state)
    (electric-pair-mode t) ; auto paren complete
    ;; call my function to set c/c++ mode default indentation style
    (c-add-style "my-style" my-cc-style t)
    (paren-toggle-open-paren-context 1) ; adapt mic-paren-mode context for
                                        ; c-style procedural language
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
;;
;;;;;;;;;;;;;;;;;;;;;;;;; Section III IDE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;

;; enable cedet submodes
(setq semantic-default-submodes 
      '(global-semanticdb-minor-mode         ; save parsing result in db
        global-semantic-idle-scheduler-mode  ; parsing the current buffer
        global-semantic-idle-summary-mode    ; show function signature @caller in minibuffer        
        global-semantic-highlight-func-mode  ; highlight the function at the cursor
        global-semantic-idle-local-symbol-highlight-mode ; highlight variables
                                                         ; of the same name
        global-semantic-decoration-mode
        ))

;; DISABLED semantic features
;; global-semantic-tag-folding-mode       ; not available anymore, use senator version 
;; global-semantic-idle-breadcrumbs-mode ; don't support modeline yet. headline
                                         ; can use stickyfunc mode
;; global-semantic-stickyfunc-mode      ; show function signature in
                                        ; its definition on header line, but
                                        ; keep tabbar for now
;; global-semantic-mru-bookmark-mode     ; to allow semantic-mrub-switch-tag (C-x B)
					 ; not working with official CEDET

(semantic-mode)

;; let semanticdb take gtags for these modes
;; defined in semantic/db-global
(semanticdb-enable-gnu-global-databases 'c++-mode)
(semanticdb-enable-gnu-global-databases 'php-mode)

;; speedbar mode
(add-hook 'speedbar-load-hook 
   '(lambda ()
      ;; let speedbar work with semantic      
      (require 'semantic/sb)
      ;; add speedbar extensions
      (speedbar-add-supported-extension '(".php" ".inc"))
    )
)
(add-hook 'speedbar-mode-hook
   '(lambda ()
      ;; turn off linum mode in speedbar window due to conflict, linum-mode is
      ;; buffer-local, not working in speedbar-load-hook
      (linum-mode -1)
    )
)

;; Due to tramp support issues, may want to disable ECB, use speedbar for code browsing
;; Emacs Code Browser (ECB)

(require 'ecb)
(setq ecb-auto-activate t)
;; show-or-hide only takes effect after ecb is activated
(setq ecb-major-modes-show-or-hide '((c-mode php-mode) fundamental-mode lisp-interaction-mode))
(setq ecb-add-path-for-not-matching-files '(nil))
(setq ecb-options-version "2.40")

;; (define-key global-map "\C-c`" 'ecb-restore-default-window-sizes)

;; '(ecb-activate-hook (quote (ecb-eshell-auto-activate-hook)))
;; ;;'(ecb-auto-activate t)
;; '(ecb-before-activate-hook nil)
;; '(ecb-layout-window-sizes nil)
;; '(ecb-process-non-(save-excursion )mantic-files nil)
(setq ecb-tip-of-the-day nil)
;; '(ecb-windows-width 0.14)
