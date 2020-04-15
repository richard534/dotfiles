;; emacs package archives config
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

; When packages cache is empty - automatically update the list of packages
(when (not package-archive-contents)
    (package-refresh-contents))

;; load org-formatted init file
(require 'org)
(org-babel-load-file
  (expand-file-name "init.el.org"
                     user-emacs-directory))
(put 'narrow-to-region 'disabled nil)
