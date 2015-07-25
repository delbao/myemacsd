;;; tabbar-setup.el --- define customized tabbar functions
;; article: toggle group function
;; http://zhangda.wordpress.com/2012/09/21/tabbar-mode-rocks-with-customization/
(tabbar-mode t)

;; hide emacs buffers starting w/ " *", and special modes buffers
;; tabbar-buffer-list-function variable contains all buffers referred to by
;; tabbar-buffer-groups-function 
(setq tabbar-buffer-list-function
      (lambda ()
        (remove-if
         (lambda(buffer)
           (or
            (find (aref (buffer-name buffer) 0) " *")
            (memq major-mode '(dired-mode help-mode apropos-mode Info-mode Man-mode))))
         (buffer-list))))

;; this function generates lists of buffers grouped by the same condition, e.g., name
(defun tabbar-buffer-groups-by-dir ()
  "Put all files in the same directory into the same tab bar"
  (with-current-buffer (current-buffer)
    (let ((dir (expand-file-name default-directory)))
      (cond ;; assign group name until one clause succeeds, so the order is important
       (t (list dir))))))

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups-by-dir)

;; sort tabs by name
(defun tabbar-add-tab (tabset object &optional append_ignored)
  "Add to TABSET a tab with value OBJECT if there isn't one there yet.
 If the tab is added, it is added at the beginning of the tab list,
 unless the optional argument APPEND is non-nil, in which case it is
 added at the end."
  (let ((tabs (tabbar-tabs tabset)))
    (if (tabbar-get-tab object tabset)
        tabs
      (let ((tab (tabbar-make-tab object tabset)))
        (tabbar-set-template tabset nil)
        (set tabset (sort (cons tab tabs)
                          (lambda (a b) (string< (buffer-name (car a)) (buffer-name (car b))))))))))

(provide 'tabbar-setup)
