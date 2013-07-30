;;;;;;;;;;;;;; global editing features ;;;;;;;;;;;;;;;;;;;

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
