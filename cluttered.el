;;;;;;;;;;;;;;;;;;;;generic;;;;;;;;;;;;;;;;;;;;;;;;;;



;; specific this is a UNIX filesystem and don't translate EOL, Windows-specific: no longer needed with tramp mode
;; (add-untranslated-filesystem "Y:")

;;;;;;;;;;;; global key mapping
(define-key global-map "\C-c`" 'ecb-restore-default-window-sizes)
(global-set-key [f12] 'compile)

;; quickly find header/cpp matching, c-mode-common-hook is for both c/c++ mode
(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; goto-line M-g-g only works in Debian and Ubuntu
(global-set-key "\C-l" 'goto-line)

;; windmove
(windmove-default-keybindings 'meta) ;; windmove cua mode default binding meta, 
                                     ;; the original default is shift+arrow which is bind to selection extension in emacs

;; comment out below so that shift+arrow doesn't kick in
;;(when (fboundp 'windmove-default-keybindings)
;;      (windmove-default-keybindings))

;;;;;;;;;;;; programming special
;; hookd .h to c++-mode instead of c-mode 
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;;(require 'workgroups)
;;(setq wg-prefix-key (kbd "C-c w"))

;; prevent 'Command attempted to use minibuffer while in minibuffer'
(defun stop-using-minibuffer()
	"kill the minibuffer"
	(when (and (>= (recursion-depth) 1) (active-minibuffer-window)) 
		(abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

;;;;;;;;;;;;;;;;;;;;;;revive;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume-revive "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)

;; key binding for revive
(define-key ctl-x-map "S" 'save-current-configuration)
(define-key ctl-x-map "F" 'resume-revive)
(define-key ctl-x-map "K" 'wipe)

;;;;;;;;;;;;;;;;;;;;;;tabbar;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;; ~/tabbar.el
;; load tabbar package
;; (load "tabbar" ) 
;; (autoload 'tabbar-mode "tabbar" "" t)
;; (add-hook 'c++-mode-hook	  ;; autoload does not auto load the package, just bind a function to a package
;;	'(lambda() (tabbar-mode 1)))
(require 'tabbar)
(tabbar-mode t)

;; redefine tabbar groups
;; return the list of group names the current buffer belongs to
(defun tabbar-buffer-groups ()
  (list
   (cond
    ((string-equal "*" (substring (buffer-name) 0 1)) ;; emacs buffers start with "*"
     "Emacs Buffer"
    ) 
    ((string-equal "test" (substring (buffer-name) 0 4))
     "Test Code"
    )
    ((string-equal "Test" (substring (buffer-name) 0 4))
     "Test Aide"
    )	
    ((string-equal "cc" (substring (buffer-name) -2 nil))
     "Source Code"
    )
    ((or (string-equal "h" (substring (buffer-name) -1 nil)) 
(string-equal "hh" (substring (buffer-name) -2 nil)))
     "Header File"
    )
    ((or (string-equal "pl" (substring (buffer-name) -2 nil)) 
(string-equal "pm" (substring (buffer-name) -2 nil)))
     "Perl File"
    )
    ((eq major-mode 'dired-mode)
     "Dired"
    )
    (t
     "Other Buffers"
    )
    )))

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

;; set key for forward/backward scroll
(global-set-key [M-s-left] 'tabbar-backward)
(global-set-key [M-s-right] 'tabbar-forward)

;;;;;;;;;;;;;;;;;;;;;;;CEDET;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load Cedet which comes with emacs 23
(require 'cedet)
(global-ede-mode t)

;;;;;;;;;;;;;;;;;;;;;;;ecb;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load ecb
(setq stack-trace-on-error t) ;; prevent error: "Symbol's value as variable is void: stack-trace-on-error"
;; (add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
(require 'ecb-autoloads)

;;;;;;;;;;;;;;;;;;;;desktop menu;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'desktop-menu)
;;(desktop-menu) ;; auto run it at start up
(global-set-key [(control meta d)] 'desktop-menu) ;; C-X-D for cmd

;;;;;;;;;;;;;;;;;;;;auctex;;;;;;;;;;;;;;;;;;;;
;; ACUTeX replaces latex-mode-hook with LaTeX-mode-hook
(add-hook 'LaTeX-mode-hook
(lambda ()
(setq TeX-auto-save t)
(setq TeX-parse-self t)
 (setq-default TeX-master nil)
(reftex-mode t)
(TeX-fold-mode t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(c-basic-offset 4)
 '(c-default-style (quote ((c-mode . "linux") (c++-mode . "linux") (java-mode . "java") (awk-mode . "awk"))))
 '(cc-search-directories (quote ("." "/usr/include" "/usr/local/include/*" "../../src" "../include/dht/")))
 '(compilation-scroll-output t)
 '(cua-mode t nil (cua-base))
 '(desktop-file-name-format (quote absolute))
 '(desktop-load-locked-desktop t)
 '(desktop-menu-autosave t)
 '(desktop-menu-clear t)
 '(desktop-menu-directory "~/.emacs.d/")
 '(desktop-path (quote ("~/.emacs.d/" "~")))
 '(ecb-activate-hook (quote (ecb-eshell-auto-activate-hook)))
 '(ecb-auto-activate nil)
 '(ecb-before-activate-hook nil)
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(ecb-process-non-semantic-files nil)
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 0.14)
 '(ff-always-in-other-window t)
 '(fill-column 80)
 '(font-lock-global-modes (quote (not speedbar-mode)))
 '(gdb-show-main t)
 '(gtags-select-buffer-single nil)
 '(gtags-suggested-key-mapping t)
 '(ido-mode (quote both) nil (ido))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(iswitchb-mode t)
 '(safe-local-variable-values (quote ((c-file-style . GNU) (Indent . Inktomi4) (c-file-offsets (substatement-open . 0)))))
 '(tramp-default-host "sportspot-dl-vm1.corp.yahoo.com")
 '(tramp-default-method "plink")
 '(tramp-default-proxies-alist (quote (("\\\\`yahoo\\\\.com\\\\'" "nil" "/tunnel:7.194.123.149#808"))))
 '(tramp-default-user "dbao")
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-separator "."))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;;;;; CEDET setting after custom set variables

;; semantic is part of CEDET
;; (semantic-mode 1)

;; speedbar
;; (global-set-key [(f4)] 'speedbar-get-focus)

;; auto-complete
;; (require 'semantic/ia)
;; (add-hook 'c++-mode-hook 'my-c++-mode-keymap)
;; (defun my-c++-mode-keymap ()
;;        (define-key c-mode-base-map [(control tab)] 'semantic-ia-complete-symbol-menu))

;; use gtags TAGS in semanticdb
;; (require 'semantic/db-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;;;;;;; Include Setting ;;;;;;;;;;;;;;;;;
;;(require 'semantic/bovine/gcc)
;;(require 'semantic/bovine/c)

;; user include dirs can use relative dir
;;(defconst cedet-user-include-dirs
;;      (list "." ".." "../include/dht"))


;;(let (include-dirs cedet-sys-include-dirs)
;;(mapc (lambda(dir)
;;        (semantic-add-system-include dir 'c++-mode) ;; semantic-add-system-include dir &optional mode add dir as a system include path for the major mode
;;      (semantic-add-system-include dir 'c-mode))
;;       include-dirs))

;;;;;;; ECB setting after custom set variables
;; global key for toggle ecb
(global-set-key [f5] 'ecb-activate)
(global-set-key [f6] 'ecb-deactivate)
