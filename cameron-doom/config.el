;;; private/ckingsbury/config.el -*- lexical-binding: t; -*-

(load! +secrets)

(when (featurep 'evil)
  (load! +bindings)
  (load! +company)
  (load! +custom-functions)
  ;(load! +custom-text-objects)
  (load! +el)
  (load! +evil)
  (load! +git)
  (load! +haskell)
  (load! +js)
  ;(load! +lsp)
  (load! +magit)
  (load! +org)
  (load! +projectile)
  (load! +slack)
  (load! +spotify)
  (load! +style)
  (load! +ui))

