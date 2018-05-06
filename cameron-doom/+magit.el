(def-package! magit
  :config
  (defun magit-commit-wip ()
    (interactive)
    (magit-stage-modified)
    (magit-stage-untracked)
    (magit-commit '("-m wip")))
  (magit-define-popup-action 'magit-commit-popup
    ?W "WIP" 'magit-commit-wip))

(def-package! evil-magit
  :when (featurep! :feature evil)
  :after magit
  :config
  (setq evil-magit-state 'normal)
  (map! :map (magit-mode-map magit-blame-read-only-mode-map)
        doom-leader-key nil))
