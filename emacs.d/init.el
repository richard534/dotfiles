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
 '(package-selected-packages (quote (doom-themes scala-mode evil)))
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
  (message "Tell yee"))

; font settings
(set-frame-font "Open Sans 16" nil t)

; custom function to set frame size depending on resolution of computer
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist
         (cons 'height (/ (- (x-display-pixel-height) 200)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)

; start emacs-server (for use with emacsclient)
(server-start)

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
(setq org-hide-emphasis-markers t) ; hide bold bullet points etc

