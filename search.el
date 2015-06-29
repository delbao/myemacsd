;;;;;;;;;;;;;;;;;;;;;;;;Etags;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; set etags table list
;;
;;(setq tags-table-list      
;;      '("~/svndev/"))



;; platform dependent setting
;; TO-DO make it a callback function or c-like macro

; ggtags shortcut reminder https://github.com/leoliu/ggtags
; M-. ggtags-find-tag-dwim
; M-] ggtags-find-reference
; M-[ ggtags-find-definition (local-key-set)
; C-c M g ggtags-grep – Grep for references
; C-c M f ggtags-find-file
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
        '(lambda() (ggtags-mode 1)
           (local-set-key (kbd "M-[") 'ggtags-find-definition)
     )
  )
 )
)

(setq ggtags-oversize-limit 1048
      ggtags-auto-jump-to-first-match nil)

;; 'occur take current word as input
(defun occur-symbol-at-point ()
   (interactive)
   (let ((sym (thing-at-point 'symbol)))
     (if sym
        (push (regexp-quote sym) regexp-history)) ;regexp-history defvared in replace.el
       (call-interactively 'occur)))
;; key binding for 'occur-symbol-at-point
(global-set-key (kbd "M-s o") 'occur-symbol-at-point)
