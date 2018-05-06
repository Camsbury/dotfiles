(add-hook! js-mode
  (require 'evil-text-objects-javascript)
  (flycheck-mode)
  (setq js2-basic-offset 2)
  (rainbow-delimiters-mode)
  (evil-text-objects-javascript/install))

(def-package! flow-minor-mode
  :config
  (add-hook 'js2-mode-hook #'flow-minor-mode))

(def-package! company-flow
  :init
  (defun flow/set-flow-executable ()
    (interactive)
    (let* ((root (locate-dominating-file buffer-file-name  "node_modules/flow-bin"))
           (executable (car (file-expand-wildcards
                             (concat root "node_modules/flow-bin/*osx*/flow")))))
      (setq-local company-flow-executable executable)
      ;; These are not necessary for this package, but a good idea if you use
      ;; these other packages
      (setq-local flow-minor-default-binary executable)
      (setq-local flycheck-javascript-flow-executable executable)))
  :config
  (add-hook 'rjsx-mode-hook #'flow/set-flow-executable)
  (add-to-list 'company-flow-modes 'rjsx-mode)
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-flow)))

(def-package! flycheck-flow
  :config
  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'javascript-flow 'rjsx-mode)
    (flycheck-add-mode 'javascript-flow 'flow-minor-mode)
    (flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
    (flycheck-add-next-checker 'javascript-flow 'javascript-eslint)))

;; eslint integration with flycheck
(setq flycheck-javascript-eslint-executable "~/projects/urbint/grid-front-end/node_modules/.bin/eslint")

;; general css settings
(setq css-indent-offset 2)

(def-package! prettier-js
  :config
  (add-hook 'js2-mode-hook #'prettier-js-mode)
  (add-hook 'json-mode-hook #'prettier-js-mode)
  (add-hook 'css-mode-hook #'prettier-js-mode))

(def-package! rjsx-mode
  :bind (:map rjsx-mode-map
              ("<" . nil)
              ("C-d" . nil)
              (">" . nil))
  :config
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode)))
