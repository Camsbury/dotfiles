(def-package! dante)

(add-hook! haskell-mode
  (setq
   whitespace-line-column 80
   whitespace-style
   '(face trailing lines-tail))
  (whitespace-mode t)
  (auto-fill-mode t)
  (rainbow-delimiters-mode)
  (require 'hasky-extensions)
  (require 'hasky-stack)
  (require 'evil-text-objects-haskell)
  (evil-text-objects-haskell/install)
  (dante-mode)
  (flycheck-mode)
  (flycheck-add-next-checker 'haskell-dante '(warning . haskell-hlint)))

(after! haskell-mode
  (flycheck-mode)
  (setq haskell-font-lock-symbols-alist (-reject
                                         (lambda (elem)
                                           (string-equal "()" (car elem)))
                                         haskell-font-lock-symbols-alist))
  (setq haskell-font-lock-symbols-alist (cons '("^." "⌾" haskell-font-lock-dot-is-not-composition) haskell-font-lock-symbols-alist))
  (setq haskell-font-lock-symbols-alist (cons '("<>" "⊕" haskell-font-lock-dot-is-not-composition) haskell-font-lock-symbols-alist))
  (setq haskell-font-lock-symbols t))
