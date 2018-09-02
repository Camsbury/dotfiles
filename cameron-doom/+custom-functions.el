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
  (pretty-split)
  (projectile-find-file))

(defun +spawn-recent-file ()
  "opens a new vertical split, along with a fzf for a recent file"
  (interactive)
  (require 'projectile)
  (pretty-split)
  (counsel-recentf))

(defun open-tmp-org ()
  "opens a temporary org file"
  (interactive)
  (pretty-split)
  (find-file "/tmp/notes.org"))

(defun eww-new ()
  "opens a new eww buffer"
  (interactive)
  (let ((url (read-from-minibuffer "Enter URL or keywords: ")))
    (switch-to-buffer (generate-new-buffer "eww"))
    (eww-mode)
    (eww url)))

(defun empire/haskell/module->test ()
  "Jump from a module to a test."
  (let ((filename (->> buffer-file-name
                       (s-replace "/src/" "/test/")
                       (s-replace ".hs" "Test.hs"))))
    (make-directory (f-dirname filename) t)
    (find-file filename)))

(defun empire/haskell/test->module ()
  "Jump from a test to a module."
  (let ((filename (->> buffer-file-name
                       (s-replace "/test/" "/src/")
                       (s-replace "Test.hs" ".hs"))))
    (make-directory (f-dirname filename) t)
    (find-file filename)))

(defun empire/haskell/test<->module ()
  "Toggle between test and module in Haskell."
  (if (s-contains? "/src/" buffer-file-name)
      (empire/haskell/module->test)
    (empire/haskell/test->module)))

(defun empire/test<->module ()
  "Toggle between test and module"
  (interactive)
  (if (s-ends-with? ".hs" buffer-file-name)
      (empire/haskell/test<->module)))

(defun set-window-width (count)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- count (window-width)) t))

(defun prettify-windows ()
  "Set the windows all to have 83 chars of length"
  (interactive)
  (let ((my-window (selected-window)))
    (select-window (frame-first-window))
    (while (window-next-sibling)
      (set-window-width 85)
      (select-window (window-next-sibling)))
    (select-window my-window)))

(defun pretty-delete-window ()
  "Cleans up after itself after deleting current window"
  (interactive)
  (let ((new-window (window-prev-sibling)))
    (delete-window)
    (prettify-windows)))

(defun pretty-split ()
  (interactive)
  "Does a vsplit and prettifies"
  (evil-window-vsplit)
  (prettify-windows))
