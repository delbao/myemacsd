;;;;;;;;;;;;;; global editing features ;;;;;;;;;;;;;;;;;;;

(require 'smart-operator)

; enable yasnippet menu globally
(yas-global-mode 1)

; set global tab width to 4, use by other modes
(setq-default tab-width 4)

; whole line or region cut/copy, not work in CUA
(defun my-kill-ring-save (beg end flash)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2) 'flash)))
  (kill-ring-save beg end)
  (when flash
    (save-excursion
      (if (equal (current-column) 0)
          (goto-char end)
        (goto-char beg))
      (sit-for blink-matching-delay))))
(global-set-key [remap kill-ring-save] 'my-kill-ring-save)

; mic-paren mode depend on show-paren-mode
; http://www.emacswiki.org/emacs/mic-paren.el
(paren-activate)

;;
;; If set to 'swap (default), the buffers will be exchanged Hide
;; (i.e. swapped), if set to 'move, the current window is switch back to the
;; previously displayed buffer (i.e. the buffer is moved).
(setq buffer-move-behavior 'move)
