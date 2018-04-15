;;; ../../projects/dotfiles/cameron-doom/+text-objects.el -*- lexical-binding: t; -*-



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Regex Macro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro define-and-bind-text-object (key start-regex end-regex)
  (let ((inner-name (make-symbol "inner-name"))
        (outer-name (make-symbol "outer-name")))
    `(progn
       (evil-define-text-object ,inner-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count nil))
       (evil-define-text-object ,outer-name (count &optional beg end type)
         (evil-select-paren ,start-regex ,end-regex beg end type count t))
       (define-key evil-inner-text-objects-map ,key (quote ,inner-name))
       (define-key evil-outer-text-objects-map ,key (quote ,outer-name)))))

(define-and-bind-text-object "l" "^\\s-*" "\\s-*$") ;; lines
(define-and-bind-text-object "e" "\\`\\s-*" "\\s-*\\'") ;; entire buffers



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add Text Object Macro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro define-major-mode-text-object (key inner-object outer-object)
  `(progn
     (define-key evil-operator-state-local-map (s-concat "i" ,key) ,inner-object)
     (define-key evil-visual-state-local-map (s-concat "i" ,key) ,inner-object)
     (define-key evil-operator-state-local-map (s-concat "a" ,key) ,outer-object)
     (define-key evil-visual-state-local-map (s-concat "a" ,key) ,outer-object)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Haskell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: Update to smarter regex searches for both.
;; Single-line comments
(evil-define-text-object evil-inner-haskell-comment (count &optional beg end type)
  (let ((beg (save-excursion (search-backward "--") (right-char 2) (point)))
        (end (save-excursion (search-forward "\n") (left-char 1) (point))))
    (evil-range beg end)))

(evil-define-text-object evil-outer-haskell-comment (count &optional beg end type)
  (let ((beg (save-excursion (search-backward "--") (point)))
        (end (save-excursion (search-forward "\n") (left-char 1) (point))))
    (evil-range beg end)))


;; Comment Blocks
(evil-define-text-object evil-inner-haskell-comment-block (count &optional beg end type)
  (let ((beg (save-excursion (search-backward "{-") (right-char 2) (point)))
        (end (save-excursion (search-forward  "-}\n") (left-char 3) (point))))
    (evil-range beg end)))

(evil-define-text-object evil-outer-haskell-comment-block (count &optional beg end type)
  (let ((beg (save-excursion (search-backward "{-") (point)))
        (end (save-excursion (search-forward  "-}\n") (point))))
    (evil-range beg end)))

;; Collect Haskell Objects
(defun add-evil-text-objects-for-haskell ()
  (define-major-mode-text-object "c" 'evil-inner-haskell-comment 'evil-outer-haskell-comment)
  (define-major-mode-text-object "C" 'evil-inner-haskell-comment-block 'evil-outer-haskell-comment-block))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(evil-define-text-object
  evil-outer-javascript-function (count &optional beg end type)
  "Outer text object for all Javascript functions."
  (call-interactively #'mark-defun)
  (narrow-to-region (region-beginning) (region-end))
  (goto-char (point-min))
  (let* ((beg (save-excursion
                (when (looking-at "[[:space:]]")
                  (evil-forward-word-begin))
                (point)))
         (end (save-excursion
                (goto-char beg)
                (search-forward "(")
                (backward-char)
                (evil-jump-item)
                (search-forward-regexp "[({]")
                (evil-jump-item)
                (forward-char)
                (point))))
    (evil-range beg end type)))

(evil-define-text-object
  evil-inner-javascript-function (count &optional beg end type)
  "Inner text object for all Javascript functions."
  (call-interactively #'mark-defun)
  (narrow-to-region (region-beginning) (region-end))
  (goto-char (point-min))
  (let* ((beg (save-excursion
                (search-forward "(")
                (backward-char)
                (evil-jump-item)
                (search-forward-regexp "[({]")
                (point)))
         (end (save-excursion
                (goto-char beg)
                (evil-jump-item)
                (point))))
    (evil-range beg end type)))

;; Collect JavaScript Objects
(defun add-evil-text-objects-for-haskell ()
  (define-major-mode-text-object "c" 'evil-inner-haskell-comment 'evil-outer-haskell-comment)
  (define-major-mode-text-object "C" 'evil-inner-haskell-comment-block 'evil-outer-haskell-comment-block))

