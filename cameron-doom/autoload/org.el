;;; ../../projects/dotfiles/cameron-doom/autoload/org.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +camsbury/open-tmp-org ()
  "opens a temporary org file"
  (interactive)
  (evil-window-vsplit)
  (find-file "/tmp/notes.org"))
