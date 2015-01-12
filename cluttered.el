;;;;;;;;;;;;;;;;;;;;generic;;;;;;;;;;;;;;;;;;;;;;;;;;



;; specific this is a UNIX filesystem and don't translate EOL, Windows-specific: no longer needed with tramp mode
;; (add-untranslated-filesystem "Y:")

;;;;;;;;;;;; programming special

;; prevent 'Command attempted to use minibuffer while in minibuffer'
(defun stop-using-minibuffer()
	"kill the minibuffer"
	(when (and (>= (recursion-depth) 1) (active-minibuffer-window)) 
		(abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

;;;;;;;;;;;;;;;;;;;;;;;CEDET;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load Cedet which comes with emacs 23
;; (require 'cedet)
;; (global-ede-mode t)

;;;;;;;;;;;;;;;;;;;;;;;ecb;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq stack-trace-on-error t) ;; prevent error: "Symbol's value as variable is void: stack-trace-on-error"

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
 '(compilation-scroll-output t)
 '(cua-mode t nil (cua-base))
 '(gdb-show-main t)
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(iswitchb-mode t)
 '(safe-local-variable-values (quote ((c-file-style . GNU) (Indent . Inktomi4) (c-file-offsets (substatement-open . 0)))))
 '(tramp-default-host "sportspot-dl-vm1.corp.yahoo.com")
 '(tramp-default-method "plink")
 '(tramp-default-proxies-alist (quote (("\\\\yahoo\\\\.com\\\\'" "nil" "/tunnel:7.194.123.149#808"))))
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


;; auto-complete
;; (require 'semantic/ia)
;; (add-hook 'c++-mode-hook 'my-c++-mode-keymap)
;; (defun my-c++-mode-keymap ()
;;        (define-key c-mode-base-map [(control tab)] 'semantic-ia-complete-symbol-menu))


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
