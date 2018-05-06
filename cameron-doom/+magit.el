(def-package! magit
  :config
  (defun magit-commit-wip ()
    (interactive)
    (magit-commit "-m wip"))
  (magit-define-popup-action 'magit-commit-popup
    ?w "WIP" 'magit-commit-wip))
