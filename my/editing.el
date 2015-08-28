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

;;
;; define ff-find-other-file-in-other-window to open in other window (key C-c 4 o)
;; ff-find-other-file only has a setting ff-always-in-other-window to always
;; open in a new window. define a new function to open in other window so we
;; have two functions to open either in this window or the other window
;;
(defun ff-find-other-file-in-other-window (arg)
  (interactive "p")
  (if (= arg 4)
      (ff-find-other-file)
    (progn (if (and (= (length (window-list)) 1)(> (frame-width) 150))
	       (split-window-horizontally))
      (ff-find-other-file t))))

(global-set-key [(control c)(?5)(o)] 'ff-find-other-file-in-other-window)

;; move line or selected region up/down, default binding M-Up/M-Down
(require 'move-text)
(move-text-default-bindings)

;; flipping buffers in two frames
(defun switch-buffers-between-frames ()
  "switch-buffers-between-frames switches the buffers between the two last frames"
  (interactive)
  (let ((this-frame-buffer nil)
        (other-frame-buffer nil))
    (setq this-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (other-frame 1)
    (setq other-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (switch-to-buffer this-frame-buffer)
    (other-frame 1)
    (switch-to-buffer other-frame-buffer)))

(global-set-key (kbd "C-c b") 'switch-buffers-between-frames)
