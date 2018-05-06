;; Spaces over tabs TODO: define details
(setq c-basic-indent 2)
(setq c-default-style "linux")
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

;; Turn off line wrapping TODO: test
(setq-default truncate-lines 1)

;; enforce max-line length
(setq-default fill-column 80)

(add-hook 'before-save-hook 'whitespace-cleanup)

;; Make line numbers pop - invalid face linum
;; (set-face-foreground 'linum "#ddb275")
