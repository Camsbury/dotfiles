
(def-package! magit
  :config
  (defun magit-commit-wip ()
    (interactive)
    (magit-stage-modified)
    (magit-stage-untracked)
    (magit-commit '("-m wip")))
  (magit-define-popup-action 'magit-commit-popup
    ?W "WIP" 'magit-commit-wip))

;; magit-section-forward/backward
;; magit-diff-less/more/default-context

(def-package! evil-magit
  :when (featurep! :feature evil)
  :after magit
  :config
  (setq evil-magit-state 'normal)
  (map! :map (magit-mode-map magit-blame-read-only-mode-map)
        doom-leader-key nil))

(map!
 ;; evil-magit
 (:after evil-magit
   :map (magit-status-mode-map magit-revision-mode-map)
   :n "C-j" nil
   :n "C-k" nil
   :n "j" #'magit-section-forward
   :n "k" #'magit-section-backward
   )

 ;; git-timemachine
 (:after git-timemachine
   (:map git-timemachine-mode-map
     :nv "p" #'git-timemachine-show-previous-revision
     :nv "n" #'git-timemachine-show-next-revision
     :nv "g" #'git-timemachine-show-nth-revision
     :nv "q" #'git-timemachine-quit
     :nv "w" #'git-timemachine-kill-abbreviated-revision
     :nv "W" #'git-timemachine-kill-revision
     :nv "b" #'git-timemachine-blame)))

(def-package! smeargle)
(def-package! evil-ediff)
