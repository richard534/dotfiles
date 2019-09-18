; install MELPA
(require 'package)

;; Set package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                     ("marmalade" . "http://marmalade-repo.org/packages/")
                     ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; exec-path-from-shell package config
; ensure environment variables inside Emacs look the same as in the user's shell.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Custom config
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; Custom fn that opens helm-projectile-ag if currently in a projectile project
; otherwise opens helm-ag
(defun maybe-helm-projectile-ag ()
  (interactive)
  (call-interactively
    (if (projectile-project-p)
       #'helm-projectile-ag
       #'helm-ag)))

;; Custom fn that opens helm-projectile-find-file if currently in a projectile project
; otherwise opens helm-find-files
(defun maybe-helm-projectile-find-file ()
  (interactive)
  (call-interactively
    (if (projectile-project-p)
       #'helm-projectile-find-file
       #'helm-find-files)))

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
; bind evil-keys
(evil-leader/set-key
  "<SPC>" 'evil-ex-nohighlight ; ripgrep text search inside current project
  "i" 'helm-projectile-ag ; file search inside current project
  "t" 'helm-projectile-find-file ; file search inside current project
  ";" 'helm-buffers-list ; helm buffers list
  "fs" `helm-imenu ; mnemonic - file-structure
  "r" `anzu-query-replace-at-cursor ; buffer-wide find/replace
  "R" `projectile-replace ; project-wide find/replace

  ; evil-nerd-commenter evil-leader bindings
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "."  'evilnc-copy-and-comment-operator
)

(require 'evil)
(evil-mode 1)
; :q deletes window - keeps buffer
(evil-ex-define-cmd "q" 'delete-window)
; :quit closes emacs
(evil-ex-define-cmd "quit" 'save-buffers-kill-emacs)
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
; map cursor color to evil vim mode
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
; rebind split window keys
(define-key evil-normal-state-map (kbd "C-|") 'split-window-horizontally)
(define-key evil-normal-state-map (kbd "C--") 'split-window-vertically)
; rebind move window keys
(define-key evil-normal-state-map (kbd "C-S-k") 'buf-move-up)
(define-key evil-normal-state-map (kbd "C-S-j") 'buf-move-down)
(define-key evil-normal-state-map (kbd "C-S-h") 'buf-move-left)
(define-key evil-normal-state-map (kbd "C-S-l") 'buf-move-right)

; Make tabs work like they do in vim (tab key inserts spaces/tabs)
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

;; Bind vim-style GoTo commands
; mnemonic - goto file
(define-key evil-normal-state-map "gf" `maybe-helm-projectile-find-file)
(define-key evil-normal-state-map "gF" `helm-find-files)
; mnemonic - goto symbol
(define-key evil-normal-state-map "gs" `maybe-helm-projectile-ag)
(define-key evil-normal-state-map "gS" `helm-ag-this-file)
; goto git hunks
(define-key evil-normal-state-map "g]" `diff-hl-next-hunk)
(define-key evil-normal-state-map "g[" `diff-hl-previous-hunk)
; goto todo
(define-key evil-normal-state-map "gtn" `hl-todo-next)
(define-key evil-normal-state-map "gtp" `hl-todo-previous)

; evil shortcut to select all in file
(fset 'select-all
   "ggVG")
(define-key evil-normal-state-map (kbd "C-a") 'select-all)

; evil-number package config
(require 'evil-numbers)
(global-set-key (kbd "C-=") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C--") 'evil-numbers/dec-at-pt)

;; evil-config - esc/crtl-[ triggers emacs quit function
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

; evil-magit config
(require 'evil-magit)
; enable automatic refreshing of magit buffers
(add-hook 'after-save-hook 'magit-after-save-refresh-status t)

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
; overwrite default emacs startup message
(defun display-startup-echo-area-message ()
  (message nil))
; number of lines to scroll when reach top/bottom of window
(setq scroll-step 1)
; emacs auto-refresh buffers when files changed on disk
(global-auto-revert-mode)
; auto-complete pairs of brackets/quotes etc.
(setq electric-pair-preserve-balance nil)
; Disabled "electric indent mode" - breaks some modes inc. python
(electric-indent-mode -1)

;; remember cursor position of files when reopening them
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

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
(set-default-font "Source Code Pro 14")
(require 'all-the-icons)
; run m-x all-the-icons-install-fonts

;; start emacs-server (for use with emacsclient)
(server-start)

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
;; (doom-themes-neotree-config)
; or for treemacs users
; (doom-themes-treemacs-config)
; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
; overload doom-themes "selected region" color
(set-face-attribute 'region nil :background "#666")

;; org-mode config
(setq org-startup-indented t)
(setq org-indent-mode t)
(setq org-hide-leading-stars t) ; hide orgmode heading stars
(setq org-adapt-indentation nil) ; hide orgmode heading indented stars
(setq org-hide-emphasis-markers t) ; hide bold bullet points etc
; org-mode images config
(setq org-startup-with-inline-images t) ; Show inline images by default
(setq org-image-actual-width nil) ; try to get the width from an #+ATTR.* keyword and fall back on the original width if none is found.
(setq org-list-demote-modify-bullet (quote (("+" . "-")
                                            ("*" . "-")
                                            ("1." . "-")
                                            ("1)" . "a)"))))

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

;; emacs backup files config
(setq backup-directory-alist `(("~/.emacs-saves")))
(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.

; bind key to reload emacs config
(defun reload-init-file ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
; bind key to reaload this file
(global-set-key (kbd "C-c C-r") 'reload-init-file)

; turn off all alarms (flashing bottom of screen, audible)
(setq ring-bell-function 'ignore)

; mit-scheme (sicp) setup
(setq scheme-program-name "/usr/local/bin/scheme")
(require 'xscheme)

;; diminish package config
(require 'diminish)
; TODO sometimes these diminish commands are called before their respective packages are loaded - causing them to fail
(diminish `anzu-mode)
(diminish `undo-tree-mode)
(diminish `eldoc-mode)
(diminish `visual-line-mode)
(diminish `org-indent-mode)
(diminish `flycheck-mode)
(diminish `indent-guide-mode)
(diminish `helm-mode)
(diminish `which-key-mode)
(diminish `projectile-mode)
(diminish `elpy-mode)
(diminish `flymake-mode)
(diminish `highlight-indentation-mode)
(diminish `auto-revert-mode)
(diminish `abbrev-mode)

;; Line numbers config
(define-key evil-normal-state-map (kbd "<f2>") 'display-line-numbers-mode)
; Enable line numbers only in modes that inherit prog-mode (programming mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode 1)

;; Which-key package config
(require 'which-key)
(which-key-mode)

;; emacs desktop-save-mode
(desktop-save-mode 1)

;; projectile package config
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
; enable caching projectile results (used with helm-projectile-find-file)
(setq projectile-enable-caching t)

;; Helm package config
(require 'helm)
; turns on helm completions for most standard emacs completions
(helm-mode 1)
; re-bind keys to helm functions
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
; helm projectile config
(require 'helm-projectile)
; Helm-ag config
(custom-set-variables
    '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
    '(helm-ag-command-option "--all-text")
    ; When helm-ag opened - take symbol @ current curror location - use as default search pattern
    '(helm-ag-insert-at-point 'symbol))

;; Rainbow-delimiters package config
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; company package config
(add-hook 'after-init-hook 'global-company-mode)
; No delay in showing suggestions.
(setq company-idle-delay 0)
; Show suggestions after entering one character.
(setq company-minimum-prefix-length 1)
; once at bottom of suggestions - wrap back to top
(setq company-selection-wrap-around t)
; rebind company keys
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

; indent-guide package config
(require 'indent-guide)
(indent-guide-global-mode)

;; org-download package config
(require 'org-download)
; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; emacs-neotree config
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-window-fixed-size nil)
(setq neo-theme 'arrow)

;; json-mode/json-reformat package config
(setq json-reformat:indent-width 2)

;; elpy config
(elpy-enable)
(add-hook `python-mode
          (define-key evil-normal-state-map "gd" 'elpy-goto-definition)
          (evil-leader/set-key "fc" 'elpy-black-fix-code) ; mnemonic - format-code
          (setq python-indent-offset 4))
          ;; (local-set-key (kbd "RET") 'newline-and-indent))
; use flycheck insead of fly-make
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; hl-todo config
(setq global-hl-todo-mode 1)
(global-hl-todo-mode)

;; Tabs/Spaces config
;; (setq tab-width 4)
;; (setq indent-tabs-mode nil)

;; spaceline config
(require `spaceline-config)
(spaceline-emacs-theme)
; colour spaceline modeline according to vim mode
(setq spaceline-highlight-face-func `spaceline-highlight-face-evil-state)

;; Word wrapping hooks
; Text mode
(add-hook 'prog-mode-hook '(lambda ()
    (visual-line-mode -1)
    (setq truncate-lines t
          word-wrap nil)))

; Programming mode
(add-hook 'text-mode-hook '(lambda ()
    (setq truncate-lines nil
          word-wrap t)))

;; diff-hl config
(global-diff-hl-mode)
; set diff-hl to work with unsaved buffers too
(diff-hl-flydiff-mode t)
; set left fringe width - prevent vertical splits hiding diff-hl
(setq-default left-fringe-width 16)
; diff-hl magit integration
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;; origami config
(require 'origami)
(add-hook 'prog-mode-hook
    (lambda ()
        (origami-mode)))

;; terraform-mode config
(add-hook 'terraform-mode
  (lambda ()
    (setq evil-shift-width 2)))

(defun put-file-path-on-clipboard ()
  "Put the absolute file path on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; EditorConfig config
(editorconfig-mode 1)

;; Custom fn to open emacs init file
(defun find-emacs-init-file ()
  "Edit the 'emacs-init-file', in another window."
  (interactive)
  (find-file user-init-file))
; bind evil ex-command to open init file
(evil-ex-define-cmd "init" #'find-emacs-init-file)

;; ediff config
; only hilight current diff:
(setq-default ediff-highlight-all-diffs 'nil)
; turn off whitespace checking:
(setq ediff-diff-options "-w")

;; forge config
(with-eval-after-load `magit
  (require `forge))
