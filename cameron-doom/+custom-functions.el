(defun +evil-replace-under-point ()
  "Faster than typing %s//thing/g"
  (interactive)
  (save-excursion
    (evil-ex (concat "%s/\\b" (symbol-name (symbol-at-point)) "\\b/"))))

(defun +projectile-switch-project-workspace ()
  "Use projectile prompt to find or switch projects in a workspace tab."
  (interactive)
  (require 'projectile)
  (ivy-read
   (projectile-prepend-project-name "Switch to project: ") projectile-known-projects
   :preselect (and (projectile-project-p)
                   (abbreviate-file-name (projectile-project-root)))
   :require-match t
   :action
   (lambda (project-path)
     (let ((project-name
            (file-name-nondirectory
             (directory-file-name (file-name-directory project-path)))
            ))
       (if (+workspace-exists-p project-name)
           (+workspace-switch project-name)
           (progn (+workspace-switch project-name t)
                  (counsel-projectile-switch-project-action project-path)))))))

(defun +spawn-project-file ()
  "opens a new vertical split, along with a fzf for a projectile file"
  (interactive)
  (require 'projectile)
  (evil-window-vsplit)
  (projectile-find-file))

(defun +spawn-recent-file ()
  "opens a new vertical split, along with a fzf for a recent file"
  (interactive)
  (require 'projectile)
  (evil-window-vsplit)
  (counsel-recentf))

(defun open-tmp-org ()
  "opens a temporary org file"
  (interactive)
  (evil-window-vsplit)
  (find-file "/tmp/notes.org"))

(defun eww-new ()
  "opens a new eww buffer"
  (interactive)
  (let ((url (read-from-minibuffer "Enter URL or keywords: ")))
    (switch-to-buffer (generate-new-buffer "eww"))
    (eww-mode)
    (eww url)))
