; install MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-echo-area-message "richard")
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (helm highlight-symbol evil-anzu anzu spaceline doom-themes scala-mode evil)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-block ((t (:background "gray24")))))

; enable evil mode
(setq evil-want-C-u-scroll t) ; enable vim-like crtl-u pgUp
(require 'evil)
(evil-mode 1)
;; :q should kill the current buffer rather than quitting emacs entirely
(evil-ex-define-cmd "q" 'kill-this-buffer)
;; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)

;; User interface settings
; disable gui toolbar
(tool-bar-mode -1)
; disable mac menubar
(menu-bar-mode -1)
; disable scrollbar
(toggle-scroll-bar -1)
; Prevent the cursor from blinking
(blink-cursor-mode 0)
; remove initial scratch message
(setq initial-scratch-message "")
; disable startup screen
(setq inhibit-startup-screen t)
; Don't let Emacs hurt your ears
(setq visible-bell t)
(defun display-startup-echo-area-message ()
  (message "emacs for your face"))

; configure spaceline package
(require 'spaceline-config)
(spaceline-spacemacs-theme)

; configure anzu package
(global-anzu-mode +1)
(with-eval-after-load 'evil
  (require 'evil-anzu))
(setq anzu-search-threshold 1000
anzu-cons-mode-line-p nil)

; set default font
(set-default-font "Source Code Pro 18")
; set default font for emacs --daemon / emacsclient
(setq default-frame-alist '((font . "Source Code Pro 18")
							(left-fringe . 100)
							(right-fringe . 100)
							(height . 1000)
							(width . 100)
							(vertical-scroll-bars . nil)))

; start emacs-server (for use with emacsclient)
(server-start)

; set emacs to maximize on launch
(add-to-list 'default-frame-alist '(fullscreen . maximized))

; set line break mode
(global-visual-line-mode t)

; set emacs theme (Doom-themes package config)
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-vibrant t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

; org-mode config
(setq org-startup-indented t)
(setq org-indent-mode t)
(setq org-hide-leading-stars t) ; hide orgmode heading stars
(setq org-adapt-indentation nil) ; hide orgmode heading indented stars
(setq org-hide-emphasis-markers t) ; hide bold bullet points etc
# org-mode images config
(setq org-startup-with-inline-images t) ; Show inline images by default
(setq org-image-actual-width nil) ; try to get the width from an #+ATTR.* keyword and fall back on the original width if none is found.

; add python to org-mode babel (allows executing python code in org files src blocks)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

; enable auto fill mode on text files, set to wrap lines at certain char limit
(add-hook 'text-mode-hook 'auto-fill-mode)
(setq-default fill-column 120)

; highlight-symbol config
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

; mac - focus on emacs session when opening emacs gui
(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))

  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))

  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)

  (when (display-graphic-p)
    (ns-raise-emacs)))

; emacs backup files config
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

; enable flyspell spellchecker by default
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

; bind key to reload emacs config
(defun reload-init-file ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

; bind key to reaload this file
(global-set-key (kbd "C-c r") 'reload-init-file)

; turn off all alarms (flashing bottom of screen, audible)
(setq ring-bell-function 'ignore)

