;; emacs package archives config
(setq package-archives 
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; load org-formatted init file
(require 'org)
(org-babel-load-file
 (expand-file-name "init.el.org"
                   user-emacs-directory))
