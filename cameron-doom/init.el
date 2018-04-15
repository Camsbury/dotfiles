;;; private/ckingsbury/init.el -*- lexical-binding: t; -*-


(setq exec-path
      (list "/usr/local/bin/"
            "/usr/bin/"
            "/bin/"
            "/usr/sbin/"
            "/sbin/"
            "/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9/"
            "/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9/"
            "/Applications/Emacs.app/Contents/MacOS/libexec/"
            (concat (getenv "HOME") "/.cargo/bin")
            (concat (getenv "HOME") "/.local/bin")))

(setenv "PATH" (string-join exec-path ":"))
