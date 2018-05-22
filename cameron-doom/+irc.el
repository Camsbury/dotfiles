(def-package! circe
  :config
  (setq circe-network-options
        '(("Freenode"
           :tls t
           :nick "camsbury"
           :sasl-username crice-sasl-username-private
           :sasl-password circe-sasl-password-private
           :port 6667
           :channels ( "#haskell"
                       "#emacs"
                       "#archlinux"
                       "##math"
                       "##linux"
                       "#nixos"
                       "#idris"
                       "#docker"
                       "#zsh"
                       "##security"
                       "##hardware")))))
