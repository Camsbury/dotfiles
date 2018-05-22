(map!
 (:after company
   (:map company-active-map
     "C-l"      #'company-complete-common
     "C-e"      #'company-complete-selection
     [tab]      #'yas-expand
     [escape]   (λ! (company-abort) (evil-normal-state 1))
     "<return>" #'newline
     )))


(after! company
  (setq company-idle-delay 0)
  )

