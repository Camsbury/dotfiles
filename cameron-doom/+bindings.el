;;; private/ckingsbury/+bindings.el -*- lexical-binding: t; -*-



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map!
 ;; :i   [remap newline] #'doom/newline-and-indent
 :n   "gt"            #'projectile-toggle-between-implementation-and-test
 :n   "ge"            #'flycheck-list-errors
 :niv "C-S-o"         #'evil-jump-forward
 :nv  "M-n"           #'+doom/blink-cursor ;; function no longer exists?
 :nv  "U"             #'undo-tree-visualize

 ;; Movement
 "C-h"    #'evil-window-left
 "C-j"    #'evil-window-down
 "C-k"    #'evil-window-up
 "C-l"    #'evil-window-right

 ;; Mega-x
 :nvime "M-x" #'execute-extended-command
 :nvime "A-x" #'execute-extended-command

 ;; Motion
 :i "C-a" #'doom/backward-to-bol-or-indent
 :i "C-e" #'doom/forward-to-last-non-comment-or-eol
 :i "C-u" #'doom/backward-kill-to-bol-and-indent
 :i "C-b" #'backward-word
 :i "C-f" #'forward-word

 ;; OSX-like Commands
 "M-a"    #'mark-whole-buffer
 "M-c"    #'evil-yank
 "M-v"    #'clipboard-yank
 "M-q"    (if (daemonp) #'delete-frame #'save-buffers-kill-emacs)
 "M-RET"   #'doom/toggle-fullscreen ;; function no longer exists?
 )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Leader
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 ;; ensure the leader keys aren't mapped to anything else
 :nmvo doom-leader-key nil
 :nmvo doom-localleader-key nil

 (:leader

   ;; Major Utility
   :desc "Describe key"         :nv "TAB" #'describe-key
   :desc "Spawn Project File"   :nv "DEL" #'+spawn-project-file
   :desc "Capture"              :nv "RET" #'org-capture
   :desc "Swiper"               :nv "/"   #'swiper
   :desc "eval defun"           :nv ")"   #'eval-defun
   :desc "eval and print"       :nv "}"   #'eval-print-last-sexp
   :desc "eval buffer"          :nv "("   #'eval-buffer
   :desc "Find references"      :n  "["   #'+lookup/references
   :desc "All buffers"          :nv "]"   #'switch-to-buffer
   :desc "from project"         :nv "a"   #'+projectile-switch-project-workspace
   :desc "Agenda list"          :nv "A"   #'org-agenda-list
   :desc "Jump to definition"   :nv "e"   #'+lookup/definition
   :desc "Magit status"         :nv "g"   #'magit-status
   :desc "Magit blame"          :nv "G"   #'magit-blame
   :desc "Open temp org file"   :nv "h"   #'+camsbury/open-tmp-org
   :desc "Imenu"                :nv "i"   #'imenu
   :desc "Imenu across buffers" :nv "I"   #'imenu-anywhere
   :desc "Horizontal Split"     :nv "j"   #'evil-window-split
   :desc "kill window"          :nv "k"   #'delete-window
   :desc "kill buffer"          :nv "K"   #'kill-buffer
   :desc "vertical split"       :nv "l"   #'evil-window-vsplit
   :desc "todo list"            :nv "L"   #'org-todo-list
   :desc "smerge hydra"         :nv "o"   #'+hydra-smerge/body
   :desc "Recent files"         :nv "n"   #'counsel-recentf
   :desc "Find file in project" :nv "p"   #'projectile-find-file
   :desc "Reload the project"   :nv "P"   #'projectile-invalidate-cache
   :desc "Slack IM"             :nv "s"   #'slack-im-select
   :desc "Sort"                 :nv "S"   #'sort-lines
   :desc "Find file"            :nv "t"   #'find-file
   :desc "Spawn file"           :nv "T"   #'+camsbury/spawn-file
   :desc "Save file"            :nv "w"   #'evil-write
   :desc "Save file"            :nv "W"   #'evil-write-all
   :desc "Save and close file"  :nv "q"   #'evil-save-modified-and-close
   :desc "Close file no save"   :v  "Q"   #'evil-quit

   (:desc "command tree" :prefix "SPC"
     (:desc "conf-files" :prefix "c"
       :desc "Open emacs bindings"     :nv "b" #'+camsbury/open-emacs-bindings
       :desc "Open emacs config"       :nv "c" #'+camsbury/open-emacs-config
       :desc "Open zshrc"              :nv "n" #'+camsbury/open-zshrc
       :desc "Open hammerspoon config" :nv "i" #'+camsbury/open-hammerspoon-config
       :desc "Open doom init"          :nv "o" #'+camsbury/open-doom-init
       :desc "Open ergo conf"          :nv "e" #'+camsbury/open-ergodox-bindings
       )

     (:desc "git" :prefix "g"
       :desc "Git time machine"  :n  "t" #'git-timemachine-toggle
       :desc "Git revert hunk"   :n  "r" #'git-gutter:revert-hunk
       )

     (:desc "help" :prefix "h"
       :desc "Fuzzy find descriptions" :n "a" #'apropos
       :desc "Find library"            :n "L" #'find-library
       :desc "Command log"             :n "l" #'global-command-log-mode
       :desc "Toggle Emacs log"        :n "m" #'doom/popup-toggle-messages
       :desc "Describe function"       :n "f" #'describe-function
       :desc "Describe char"           :n "c" #'describe-char
       :desc "Describe mode"           :n "M" #'describe-mode
       :desc "Describe variable"       :n "v" #'describe-variable
       :desc "Describe face"           :n "F" #'describe-face
       :desc "Describe DOOM setting"   :n "s" #'doom/describe-setting
       :desc "Describe DOOM module"    :n "d" #'doom/describe-module
       :desc "What face"               :n "'" #'doom/what-face
       :desc "What minor modes"        :n ";" #'doom/what-minor-mode
       :desc "Info"                    :n "i" #'info
       :desc "Toggle profiler"         :n "p" #'doom/toggle-profiler
       )

     (:desc "tmux" :prefix "t"
       :desc "rerun last command"  :n "n" #'+russ/tmux-repeat
       :desc "fire shell command"  :n "h" #'+russ/shell-command
       :desc "fire tmux command"   :n "t" #'+russ/tmux-command
       :desc "send cancel command" :n "c" #'+russ/tmux-cancel
       :desc "send q key"          :n "q" #'+russ/tmux-send-q
       :desc "switch client"       :n "s" #'+russ/tmux-switch-client
       )

     (:desc "workspace" :prefix "s"
       :desc "browse"         :nv "b" #'+workspace/switch-to
       :desc "load"           :nv "l" #'+workspace/load
       :desc "name"           :nv "m" #'+workspace/rename
       :desc "new"            :nv "h" #'+workspace/new
       :desc "save"           :nv "s" #'+workspace/save
       )

     (:desc "evaluate" :prefix "x"
       :desc "eval-buffer"             :nv "o" #'eval-buffer
       :desc "eval region"             :n  "r" #'+eval/region
       :desc "eval region and replace" :n  "R" #'+eval/region-and-replace
       )
     )
   )
 )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Directional Leader
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 :nv "[t" #'evil-prev-buffer
 :nv "]t" #'evil-next-buffer
 :m  "]e" #'next-error
 :m  "[e" #'previous-error
 :m  "]f" #'text-scale-increase
 :m  "[f" #'text-scale-decrease
 :nv "[s" #'+workspace/switch-left
 :nv "]s" #'+workspace/switch-right
 :nv "]j" #'evil-jump-forward
 :nv "[j" #'evil-jump-backward
 :nv "]n" #'+evil/window-move-right
 :nv "[n" #'+evil/window-move-left
 :nv "[r" #'undo-tree-save-state-to-register
 :nv "]r" #'undo-tree-restore-state-from-register)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil Editing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; basics
(map!
 ;:n "<return>"      #'evil-goto-line
 :v  "." #'evil-repeat
 ;; don't leave visual mode after shifting
 :v  "<" #'+evil/visual-dedent  ; vnoremap < <gv
 :v  ">" #'+evil/visual-indent  ; vnoremap > >gv
 ;; evil-commentary
 :n  "gc" #'evil-commentary
 ;; evil-exchange
 :n  "gx" #'evil-exchange
 ;; evil-matchit
 :nv [tab] #'+evil/matchit-or-toggle-fold)

;; highlight and edit multiple
(map!
 :v  "R"     #'evil-multiedit-match-all
 :n  "M-d"   #'evil-multiedit-match-symbol-and-next
 :n  "M-D"   #'evil-multiedit-match-symbol-and-prev
 :v  "M-d"   #'evil-multiedit-match-and-next
 :v  "M-D"   #'evil-multiedit-match-and-prev
 :nv "C-M-d" #'evil-multiedit-restore

 (:after evil-multiedit
   (:map evil-multiedit-state-map
     "M-d" #'evil-multiedit-match-and-next
     "M-D" #'evil-multiedit-match-and-prev
     "RET" #'evil-multiedit-toggle-or-restrict-region)
   (:map (evil-multiedit-state-map evil-multiedit-insert-state-map)
     "C-n" #'evil-multiedit-next
     "C-p" #'evil-multiedit-prev)))

 ;; evil multi cursor
(map!
 (:prefix "gz"
   :nv "m" #'evil-mc-make-all-cursors
   :nv "u" #'evil-mc-undo-all-cursors
   :nv "z" #'+evil/mc-toggle-cursors
   :nv "c" #'+evil/mc-make-cursor-here
   :nv "n" #'evil-mc-make-and-goto-next-cursor
   :nv "p" #'evil-mc-make-and-goto-prev-cursor
   :nv "N" #'evil-mc-make-and-goto-last-cursor
   :nv "P" #'evil-mc-make-and-goto-first-cursor)

 (:after evil-mc
   :map evil-mc-key-map
   :nv "C-n" #'evil-mc-make-and-goto-next-cursor
   :nv "C-N" #'evil-mc-make-and-goto-last-cursor
   :nv "C-p" #'evil-mc-make-and-goto-prev-cursor
   :nv "C-P" #'evil-mc-make-and-goto-first-cursor))

 ;; evil-surround
(map!
 :v  "S"  #'evil-surround-region
 :o  "s"  #'evil-surround-edit
 :o  "S"  #'evil-Surround-edit)

;; evil-snipe
(map!
 (:after evil-snipe
   ;; Binding to switch to evil-easymotion/avy after a snipe
   :map evil-snipe-parent-transient-map
   "C-;" (λ! (require 'evil-easymotion)
             (call-interactively +evil--snipe-repeat-fn)))
 )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil Ex Commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defalias 'ex! 'evil-ex-define-cmd)

(ex! "x"  #'evil-save-modified-and-close)
(ex! "X"  #'evil-save-modified-and-close)
(ex! "W"  #'evil-write)
(ex! "rm" #'+evil:delete-this-file)

;; search
(cond ((featurep! :completion ivy)
       (ex! "ag"       #'+ivy:ag)
       (ex! "agc[wd]"  #'+ivy:ag-cwd)
       (ex! "rg"       #'+ivy:rg)
       (ex! "rgc[wd]"  #'+ivy:rg-cwd)
       (ex! "sw[iper]" #'+ivy:swiper)
       (ex! "t[odo]"   #'+ivy:todo))
      ((featurep! :completion helm)
       (ex! "ag"       #'+helm:ag)
       (ex! "agc[wd]"  #'+helm:ag-cwd)
       (ex! "rg"       #'+helm:rg)
       (ex! "rgc[wd]"  #'+helm:rg-cwd)
       (ex! "sw[oop]"  #'+helm:swoop)
       (ex! "t[odo]"   #'+helm:todo)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
  (:after comint
   ;; TAB auto-completion in term buffers
   :map comint-mode-map [tab] #'company-complete))

(map!
 ;; counsel
 (:after counsel
   (:map counsel-ag-map
     [backtab]  #'+ivy/wgrep-occur  ; search/replace on results
     "C-SPC"    #'counsel-git-grep-recenter   ; preview
     )))

(map!
 ;; ivy
 (:after ivy
   :map ivy-minibuffer-map
   [escape] #'keyboard-escape-quit
   "M-v" #'yank
   "M-z" #'undo
   "C-r" #'evil-paste-from-register
   "C-k" #'ivy-previous-line
   "C-j" #'ivy-next-line
   "C-l" #'ivy-alt-done
   "C-h" #'ivy-backward-kill-word
   "C-w" #'ivy-backward-kill-word
   "C-u" #'ivy-kill-line
   "C-b" #'backward-word
   "C-f" #'forward-word)
 )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Language Specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 (:after haskell-mode
   (:map haskell-mode-map
     (:localleader
       :desc "align imports"    :nv "a" #'haskell-align-imports
       :desc "import"           :nv "i" #'+camsbury/haskell/add-import
       :desc "restart repl"     :nv "j" #'intero-repl-restart
       :desc "load repl"        :nv "l" #'intero-repl-load
       :desc "add extension"    :nv "o" #'+camsbury/haskell/add-extension
       :desc "restart intero"   :nv "r" #'intero-restart
       :desc "sort imports"     :nv "s" #'haskell-sort-imports
       :desc "get info"         :nv "f" #'intero-info
       :desc "set targets"      :nv "h" #'intero-targets
       )
     [remap evil-open-below] #'+camsbury/haskell/evil-open-below
     )
   )
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Major Mode Specific
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;; markdown
(map!
 (:after markdown-mode
   (:map markdown-mode-map
     "<backspace>" nil
     "<M-left>"    nil
     "<M-right>"   nil
     "A-<tab>"     #'markdown-cycle)))

;; TODO: make this work!
;; (map!
;;  (:after undo-tree-visualizer-mode
;;   (:map undo-tree-visualizer-selection-mode-map
;;    :invom "h" #'undo-tree-visualize-switch-branch-left
;;    :invom "l" #'undo-tree-visualize-switch-branch-right
;;    :invom "k" #'undo-tree-visualize-undo
;;    :invom "j" #'undo-tree-visualize-redo)))

 ;; help mode
(map!
 (:map help-mode-map
   :n "[["  #'help-go-back
   :n "]]"  #'help-go-forward
   :n "o"   #'ace-link-help
   :n "q"   #'quit-window
   :n "Q"   #'+ivy-quit-and-resume))

;; TODO: Make this do something!
(map!
 (:after org-mode
   (:map org-mode-map
     :i [remap doom/inflate-space-maybe] #'org-self-insert-command
     :n [evil-goto-line] #'+org/dwim-at-point
     :nv "C-j" #'evil-window-down
     :nv "C-k" #'evil-window-up
     :inv "M-]" #'org-metaright
     :inv "M-[" #'org-metaleft)))

      ;; yasnippet
(map!
 (:after yasnippet
   (:map yas-keymap
     "C-e"           #'+snippets/goto-end-of-field
     "C-a"           #'+snippets/goto-start-of-field
     "<M-right>"     #'+snippets/goto-end-of-field
     "<M-left>"      #'+snippets/goto-start-of-field
     "<M-backspace>" #'+snippets/delete-to-start-of-field
     [backspace]     #'+snippets/delete-backward-char
     [delete]        #'+snippets/delete-forward-char-or-field)
   (:map yas-minor-mode-map
     :i "<tab>" yas-maybe-expand
     :v "<tab>" #'+snippets/expand-on-region)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Legacy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 ;; Attempt to have ESC quit things
 (:map (minibuffer-local-map
        minibuffer-local-ns-map
        minibuffer-local-completion-map
        minibuffer-local-must-match-map
        minibuffer-local-isearch-map)
   [escape] #'abort-recursive-edit
   "C-r" #'evil-paste-from-register)

 (:map tabulated-list-mode-map
   [remap evil-record-macro] #'doom/popup-close-maybe)

 (:after view
   (:map view-mode-map "<escape>" #'View-quit-all))

 (:map messages-buffer-mode-map
   "M-;" #'eval-expression
   "A-;" #'eval-expression)

 (:map (evil-ex-completion-map evil-ex-search-keymap read-expression-map)
   "C-a" #'move-beginning-of-line
   "C-w" #'doom/minibuffer-kill-word
   "C-u" #'doom/minibuffer-kill-line
   "C-b" #'backward-word
   "C-f" #'forward-word
   "M-z" #'doom/minibuffer-undo))
