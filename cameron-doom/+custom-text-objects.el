;;; Code:
(require 'evil)
(require 'pcre2el)
(require 'dash)

;; Helper functions
(defun ck/search-backward-pcre (re)
  "Like `search-backward' but RE is a PCRE."
  (-> re
      rxt-pcre-to-elisp
      search-backward-regexp))

(defun ck/search-forward-pcre (re)
  "Like `search-forward' but RE is a PCRE."
  (-> re
      rxt-pcre-to-elisp
      search-forward-regexp))


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
