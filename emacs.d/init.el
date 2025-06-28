(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq make-backup-files nil)

(require 'init-gui)
(require 'init-elpa)

;; Open org-agenda on startup
;; (add-hook 'emacs-startup-hook
;;           (lambda () (org-agenda-list) (delete-other-windows)))

;; org mode config
(use-package org
  :ensure nil ; do not try to install it as it is built-in
  :config
  (setq org-directory "/Users/bytedance/Zettelkasten/org_notes")
  (setq org-agenda-files (list org-directory)))
(define-key global-map (kbd "C-c a") 'org-agenda)

;; auctex
(use-package auctex
  :ensure t)

(setq TeX-engine 'xetex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)  ; Compile to PDF by default

(add-hook 'LaTeX-mode-hook 'visual-line-mode)     ; Line wrap
(add-hook 'LaTeX-mode-hook 'flyspell-mode)        ; Spell check
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)      ; Easy math input
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)       ; RefTeX for citations
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode) ; SyncTeX

(setq TeX-source-correlate-start-server t)

;; Use XeLaTeX as the default command
(setq TeX-command-default "XeLaTeX")
;; (setq TeX-command-extra-options "-synctex=1")
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
                '("XeLaTeX" "xelatex -synctex=1 -interaction=nonstopmode %s"
                  TeX-run-TeX nil t :help "Run XeLaTeX")))

(setq TeX-view-program-selection '((output-pdf "Skim")))
(setq TeX-view-program-list
      '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o %b")))

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))))

(defun my/TeX-refresh-pdf (_output)
  "Refresh PDF buffer after successful LaTeX compilation."
  (when (eq major-mode 'pdf-view-mode)
    (pdf-view-revert-buffer nil t)))

;; (add-hook 'TeX-after-compilation-finished-functions #'my/TeX-refresh-pdf)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ruby . t)))  ;; Enable Ruby
