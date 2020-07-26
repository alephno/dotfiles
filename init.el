(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "cbd85ab34afb47003fa7f814a462c24affb1de81ebf172b78cb4e65186ba59d2" "8f5b54bf6a36fe1c138219960dd324aad8ab1f62f543bed73ef5ad60956e36ae" default)))
 '(package-selected-packages
   (quote
    (ediprolog rjsx-mode ample-theme nord-theme tabbar which-key almost-mono-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ==================   MY STUFF =================

(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(set-frame-font "Go Mono 16")
(global-linum-mode 1)
(setq inhibit-startup-screen t)

; aka gtfo of my project file tree
(setq backup-directory-alist
          `(("." . ,(concat user-emacs-directory "backups"))))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay .2))

(use-package tabbar
  :ensure t
  :config (tabbar-mode 1))

(use-package nord-theme
  :ensure t
  :config (load-theme 'nord t))

(use-package ample-theme
  :ensure t)

; pfft who uses perl anyway
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))

(use-package ediprolog
  :ensure t
  :bind ("\C-c\C-e" . 'ediprolog-dwim)
  :config (setq ediprolog-system 'swi))

(use-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
  :init
  (add-hook 'rjsx-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq js-indent-level 2)
              (setq js2-strict-missing-semi-warning nil))))
