(provide '+idris)
;;; +idris.el ends here

(def-package! idris-mode
  :mode "\\.idr$"
  :interpreter (("idris" . haskell-mode)))
