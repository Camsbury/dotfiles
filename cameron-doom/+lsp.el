;; language server integration
(def-package! lsp-mode
  :after (:any haskell-mode)
  :config
  (lsp-mode))

;; ui stuff
(def-package! lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-flycheck-enable t)
  (setq imenu-auto-rescan t)
  :hook
  (lsp-mode . lsp-ui-mode)
  (lsp-ui-mode . flycheck-mode))

;; company backend
(def-package! company-lsp
  :after (lsp-mode lsp-ui)
  :config
  (setq company-backends '(company-lsp))
  (setq company-lsp-async t))

;; haskell in particular
(def-package! lsp-haskell
  :after (lsp-mode lsp-ui haskell-mode)
  :hook
  (haskell-mode . lsp-haskell-enable))
