;;; +projectile.el -*- lexical-binding: t; -*-

(setq projectile-test-suffix-function
      (lambda (project-type)
        (case project-type
          ('haskell-stack "Test")
          ('npm ".test")
          (otherwise (projectile-test-suffix project-type)))))
