;;; ../../projects/dotfiles/cameron-doom/autoload/navigation.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +camsbury/spawn-recent ()
  "opens a new vertical split, along with a recent file fzf"
  (interactive)
  (evil-window-vsplit)
  (ivy-recentf))

;;;###autoload
(defun +camsbury/spawn-file ()
  "opens a new vertical split, along with a recent file fzf"
  (interactive)
  (evil-window-vsplit)
  (counsel-find-file))
