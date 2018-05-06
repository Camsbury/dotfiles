;; intero stuff
(def-package! intero
  :after haskell-mode
  :config
  (intero-global-mode 1)
  (add-hook 'haskell-mode-hook #'+haskell|init-intero)
  (add-hook! 'intero-mode-hook #'(flycheck-mode eldoc-mode))
  (set! :lookup 'haskell-mode :definition #'intero-goto-definition)
  ;; (require 'haskell-hlint)
  (flycheck-add-next-checker 'intero 'haskell-hlint)
  )

;; Cameron BS TODO: test
;; (custom-set-variables
;;  '(haskell-process-suggest-hoogle-imports t))

(add-hook! haskell-mode
  (setq
   whitespace-line-column 80
   whitespace-style
   '(face trailing lines-tail))
  (whitespace-mode t)
  ;; (auto-fill-mode t)
  (rainbow-delimiters-mode)
  (require 'evil-text-objects-haskell)
  (evil-text-objects-haskell/install))

(after! haskell-mode
  (flycheck-mode)
  (setq haskell-font-lock-symbols-alist (-reject
                                         (lambda (elem)
                                           (string-equal "()" (car elem)))
                                         haskell-font-lock-symbols-alist))
  (setq haskell-font-lock-symbols-alist (cons '("^." "⌾" haskell-font-lock-dot-is-not-composition) haskell-font-lock-symbols-alist))
  (setq haskell-font-lock-symbols-alist (cons '("<>" "⊕" haskell-font-lock-dot-is-not-composition) haskell-font-lock-symbols-alist))
  (setq haskell-font-lock-symbols t))
