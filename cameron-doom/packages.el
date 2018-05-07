;; -*- no-byte-compile: t; -*-

;; elisp
(package! s)
(package! dash)
(package! dash-functional)
(package! paredit)

;; elixir
(package! flycheck-credo)

;; git / diff
(package! magit)
(package! evil-magit)

(package! evil-ediff)
(package! smeargle)

;; haskell
(package! intero)
(package! hasky-stack)
(package! hasky-extensions)
(package! evil-text-objects-haskell :recipe (:fetcher github :repo "urbint/evil-text-objects-haskell"))

;; idris
(package! idris-mode)

;; js
(package! flow-minor-mode)
(package! company-flow)
(package! flycheck-flow)
(package! prettier-js)
(package! rjsx-mode)
(package! evil-text-objects-javascript :recipe (:fetcher github :repo "urbint/evil-text-objects-javascript"))

;; lsp
(package! lsp-mode)
(package! lsp-ui :recipe (:fetcher github :repo "emacs-lsp/lsp-ui"))
(package! lsp-haskell)
(package! company-lsp)

;; markdown
(package! gh-md)

;; slack
(package! slack)
(package! emojify)
(package! oauth2)
(package! circe)
(package! el-get)

;; spotify
(package! counsel-spotify)

;; ui
(package! exec-path-from-shell)
(package! restart-emacs)
