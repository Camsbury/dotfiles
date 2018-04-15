;;; private/ckingsbury/+org.el -*- lexical-binding: t; -*-

(setq org-directory (expand-file-name "~/projects/lxndr/"))

(defun +cameron/org-capture-hook ()
  (setq org-capture-templates '(("n" "Push onto Task Stack" entry
                                 (file+headline "~/projects/lxndr/task_stack.org" "Tasks")
                                 "* [ ] %i%?")
                                ("e" "Push onto Fact Stack" entry
                                 (file+headline "~/projects/lxndr/fact_stack.org" "Facts")
                                 "* [ ] %i%?"))

        org-agenda-files '("~/projects/lxndr/queue.org")))

(after! org-capture
  (+cameron/org-capture-hook))

(setq org-refile-targets '(("~/projects/lxndr/queue.org" :maxlevel . 3)
                           ("~/projects/lxndr/ref.org" :level . 1)))

(map!
 (:after org-capture
   (:map org-capture-mode-map
     [remap evil-save-and-close]          #'org-capture-finalize
     [remap evil-save-modified-and-close] #'org-capture-finalize
     [remap evil-quit]                    #'org-capture-kill)))

(setq org-archive-location (concat "~/projects/lxndr/archive/" (format-time-string "%Y-%m") ".org::"))
