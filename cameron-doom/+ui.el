(after! doom-themes
  ;; Since Fira Mono doesn't have an italicized variant, highlight it instead
  (setq doom-theme 'doom-molokai)
  (set-face-attribute 'italic nil
                      :weight 'ultra-light
                      :foreground "#ffffff"
                      :background (doom-color 'current-line)))

;; config Emacs to use $PATH values
(def-package! exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

;; If the file is in an unaltered state,
;; will update automatically to match the persisted file changing... I think
(global-auto-revert-mode t)

;; displays icons in ivy/search
(setq +ivy-buffer-icons t)

;; makes undo-tree-visualizer have a reasonable buffer height
(after! undo-tree-visualizer-mode
  (fit-window-to-buffer))

;; provides a function to restart emacs
(def-package! restart-emacs)

;; google translate in buffer
(def-package! google-translate)
