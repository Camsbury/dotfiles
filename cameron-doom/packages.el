;; -*- no-byte-compile: t; -*-
;;; private/ckingsbury/packages.el

;; align shell/emacs path
(package! exec-path-from-shell)

;; lsp
(package! lsp-mode)
(package! lsp-ui :recipe (:fetcher github :repo "emacs-lsp/lsp-ui"))
(package! lsp-haskell)
(package! company-lsp)

;; haskell
(package! intero)
(package! evil-text-objects-haskell :recipe (:fetcher github :repo "urbint/evil-text-objects-haskell"))

(package! magit)

;; elixir
(package! flycheck-credo)

;; elisp
(package! s)
(package! dash)
(package! dash-functional)
(package! paredit)

;; js
(package! flow-minor-mode)
(package! company-flow)
(package! flycheck-flow)
(package! prettier-js)
(package! rjsx-mode)
(package! evil-text-objects-javascript :recipe (:fetcher github :repo "urbint/evil-text-objects-javascript"))

;; spotify
(package! counsel-spotify)

;; slack
(package! slack)
(package! emojify)
(package! oauth2)
(package! circe)
(package! el-get)
