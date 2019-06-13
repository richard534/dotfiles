;; install MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Custom config
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; configure emacs evil package/s
; enable vim-like crtl-u pgUp
(setq evil-want-C-u-scroll t)
; Keep evil search highlights after moving cursor
(setq evil-search-module 'evil-search)

; configure evil-leader package
(global-evil-leader-mode)
(require 'evil-leader)
; set evil leader key to backslash
(evil-leader/set-leader "\\")
(evil-leader/set-key
  "<SPC>" 'evil-ex-nohighlight)

; configure emacs evil package
(require 'evil)
(evil-mode 1)
; :q should kill the current buffer rather than quitting emacs entirely
(evil-ex-define-cmd "q" 'kill-this-buffer)
; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)
; rebind keys for moving between windows
(define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
; rebind keys for resizing windows
(define-key evil-normal-state-map (kbd "M-k") #'evil-window-increase-height)
(define-key evil-normal-state-map (kbd "M-j") #'evil-window-decrease-height)
(define-key evil-normal-state-map (kbd "M-l") #'evil-window-increase-width)
(define-key evil-normal-state-map (kbd "M-h") #'evil-window-decrease-width)
; mapc ursor color to evil vim mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

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

; remove icons/text from title bar (transparent title bar)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; assuming you are using a dark theme
(setq ns-use-proxy-icon nil)
(setq frame-title-format nil)

; configure anzu package
(global-anzu-mode +1)
(with-eval-after-load 'evil
  (require 'evil-anzu))
(setq anzu-search-threshold 1000
anzu-cons-mode-line-p nil)

; set default font
(set-default-font "Source Code Pro 18")
; set default font for emacs --daemon / emacsclient
(setq default-frame-alist '((font . "Source Code Pro 16")
			    (vertical-scroll-bars . nil)))
(require 'all-the-icons)
; run m-x all-the-icons-install-fonts

;; start emacs-server (for use with emacsclient)
(server-start)
;; set line break mode
(global-visual-line-mode t)

;; set emacs theme (Doom-themes package config)
; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
; may have their own settings.
(load-theme 'doom-vibrant t)
; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
; or for treemacs users
(doom-themes-treemacs-config)
; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
;; doom-modeline package config
(require 'doom-modeline)
(doom-modeline-mode 1)
; set doom-modeline height
(setq doom-modeline-height 1)
; set doom-modeline width
(setq doom-modeline-bar-width 2)

;; Appearance
(add-hook 'after-init-hook #'fancy-battery-mode)

;; org-mode config
(setq org-startup-indented t)
(setq org-indent-mode t)
(setq org-hide-leading-stars t) ; hide orgmode heading stars
(setq org-adapt-indentation nil) ; hide orgmode heading indented stars
(setq org-hide-emphasis-markers t) ; hide bold bullet points etc
; org-mode images config
(setq org-startup-with-inline-images t) ; Show inline images by default
(setq org-image-actual-width nil) ; try to get the width from an #+ATTR.* keyword and fall back on the original width if none is found.

; add python to org-mode babel (allows executing python code in org files src blocks)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

; enable auto fill mode on text files, set to wrap lines at certain char limit
(add-hook 'text-mode-hook 'auto-fill-mode)
(setq-default fill-column 120)

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

; bind key to reload emacs config
(defun reload-init-file ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
; bind key to reaload this file
(global-set-key (kbd "C-c C-r") 'reload-init-file)

; turn off all alarms (flashing bottom of screen, audible)
(setq ring-bell-function 'ignore)

; mit-scheme (sicp) setup
(setq scheme-program-name "/usr/local/Cellar/mit-scheme/9.2_1/bin/mit-scheme")
(require 'xscheme)

;; diminish package config
(require 'diminish)
(diminish `anzu-mode)
(diminish `undo-tree-mode)
(diminish `eldoc-mode)
(diminish `visual-line-mode)
(diminish `org-indent-mode)

;; Enable line numbers (when emacs-version compatible)
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; Which-key package config
(require 'which-key)
(which-key-mode)

;; emacs desktop-save-mode
(desktop-save-mode 1)

