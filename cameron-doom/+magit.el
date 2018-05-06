(def-package! magit
  :config
  (defun magit-commit-wip ()
    (interactive)
    (magit-stage-modified)
    (magit-stage-untracked)
    (magit-commit '("-m wip")))
  (magit-define-popup-action 'magit-commit-popup
    ?W "WIP" 'magit-commit-wip))
