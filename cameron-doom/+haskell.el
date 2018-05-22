(def-package! intero
  :after haskell-mode
  :config
  (intero-global-mode 1)
  (add-hook 'haskell-mode-hook #'+haskell|init-intero)
  (add-hook! 'intero-mode-hook #'(flycheck-mode eldoc-mode))
  (set! :lookup 'haskell-mode :definition #'intero-goto-definition)
  (flycheck-add-next-checker 'intero 'haskell-hlint)
  )

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

;; (define-minor-mode brittany-haskell-mode
;;   :init-value nil
;;   :group 'haskell
;;   :lighter "Brittany-Haskell"
;;   :keymap '()
;;   )


;; (defun urbint/format-haskell-source ()
;;   (interactive)
;;   (let ((output-buffer (generate-new-buffer "brittany-out"))
;;         (config-file-path
;;          (concat (string-trim
;;                   (shell-command-to-string "stack path --project-root"))
;;                  "/brittany.yaml")))
;;     (when (= 0 (call-process-region
;;                 (point-min) (point-max)
;;                 "stack"
;;                 nil output-buffer nil
;;                 "exec" "--" "brittany" "--config-file" config-file-path))
;;       (let ((pt (point))
;;             (wst (window-start))
;;             (formatted-source (with-current-buffer output-buffer
;;                                 (buffer-string))))
;;         (erase-buffer)
;;         (insert formatted-source)
;;         (goto-char pt)
;;         (set-window-start nil wst)))))

;; (add-hook
;;  'before-save-hook
;;  (lambda ()
;;    (when (and (eq major-mode 'haskell-mode)
;;               (bound-and-true-p brittany-haskell-mode))
;;      (urbint/format-haskell-source))))
