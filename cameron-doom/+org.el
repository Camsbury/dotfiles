(setq org-directory (expand-file-name "~/projects/lxndr/"))


(setq org-directory (expand-file-name "~/projects/lxndr/")
      org-capture-templates '(("n" "Place in the Inbox" entry
                               (file+headline "~/projects/lxndr/inbox.org" "Inbox") "* [ ] %i%?"))
      org-agenda-files '("~/projects/lxndr/store.org")
      org-refile-targets '(("~/projects/lxndr/queue.org" :maxlevel . 3)
                           ("~/projects/lxndr/store.org" :level . 1)
                           ("~/projects/lxndr/ref.org" :level . 1))
      org-archive-location (concat "~/projects/lxndr/archive/" (format-time-string "%Y-%m") ".org::")
      org-todo-keywords '((sequence "[ ]" "[x]")))

(setq org-refile-targets '(("~/projects/lxndr/queue.org" :maxlevel . 3)
                           ("~/projects/lxndr/ref.org" :level . 1)))

(map!
 (:after org-capture
   (:map org-capture-mode-map
     [remap evil-save-and-close]          #'org-capture-finalize
     [remap evil-save-modified-and-close] #'org-capture-finalize
     [remap evil-quit]                    #'org-capture-kill)))

(setq org-archive-location (concat "~/projects/lxndr/archive/" (format-time-string "%Y-%m") ".org::"))
