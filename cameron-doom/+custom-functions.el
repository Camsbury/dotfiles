;;; +custom-functions.el -*- lexical-binding: t; -*-

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