;;; ../../projects/dotfiles/cameron-doom/autoload/conf-files.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +camsbury/open-emacs-bindings ()
  "opens my +bindings.el"
  (interactive)
  (evil-window-vsplit)
  (find-file "~/.doom.d/+bindings.el"))

;;;###autoload
(defun +camsbury/open-emacs-config ()
  "opens my config.el"
  (interactive)
  (evil-window-vsplit)
  (find-file "~/.doom.d/config.el"))

;;;###autoload
(defun +camsbury/open-zshrc ()
  "opens my .zshrc"
  (interactive)
  (evil-window-vsplit)
  (find-file "~/.zshrc")
  (shell-script-mode))

;;;###autoload
(defun +camsbury/open-skhdrc ()
  "opens my skhdrc"
  (interactive)
  (evil-window-vsplit)
  (find-file "~/.skhdrc")
  (shell-script-mode))

;;;###autoload
(defun +camsbury/open-chunkwm-config ()
  "opens my skhdrc"
  (interactive)
  (evil-window-vsplit)
  (find-file "~/.chunkwmrc")
  (shell-script-mode))

;;;###autoload
(defun +camsbury/open-doom-init ()
  "opens the doom init file"
  (interactive)
  (evil-window-vsplit)
  (find-file "~/.emacs.d/init.el"))

(defun +camsbury/open-ergodox-bindings ()
  "opens my ergodox keymap.c"
  (interactive)
  (evil-window-vsplit)
  (find-file "~/projects/dotfiles/camerak/keymap.c"))
