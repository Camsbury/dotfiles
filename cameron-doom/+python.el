;;; ~/projects/dotfiles/cameron-doom/+python.el -*- lexical-binding: t; -*-
;;;

(require 'lsp-python)
(require 'jedi)

;; (def-package! lsp-python
;;  :after (lsp-mode lsp-ui python-mode)
;;  :hook
;;  (python-mode . lsp-python-enable))

(add-hook! python-mode
  (setq
   whitespace-line-column 80
   whitespace-style '(face trailing lines-tail))
 (whitespace-mode t)
 (auto-fill-mode t)
 (rainbow-delimiters-mode))
 ;; (lsp-python-enable))
