;; emacs package archives config
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))

;; initialize built-in package management
(package-initialize)

;; update packages list if we are on a new install
(unless package-archive-contents
  (package-refresh-contents))

;; load org-formatted init file
(require 'org)
(org-babel-load-file
  (expand-file-name "init.el.org"
                     user-emacs-directory))
(put 'narrow-to-region 'disabled nil)
