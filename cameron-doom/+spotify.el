;;; +spotify.el -*- lexical-binding: t; -*-

(def-package! counsel-spotify
  :config
  (setq counsel-spotify-client-id spotify-client-id-private)
  (setq counsel-spotify-client-secret spotify-client-secret-private))
