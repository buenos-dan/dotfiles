;;; init.el --- Emacs 31.1 -*- lexical-binding: t; -*-

;;; Package Management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setopt use-package-always-ensure t)

;; Put auto-generated configs into a single file.
(setopt custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :noerror :nomessage)

;;; Basic Behavious
(setopt use-short-answers t              ; y/n rather than yes/no
        inhibit-startup-screen t         ; disable startup screen
        make-backup-files nil            ; disable backup file
        auto-save-default nil            ; disable auto save
        create-lockfiles nil             ; disable lock file
        indent-tabs-mode nil             ; tab -> space
        sentence-end-double-space nil
        scroll-conservatively 101)       ;

(global-auto-revert-mode 1)          ; auto revert-buffer
(save-place-mode 1)                  ; 
(savehist-mode 1)                    ; save minibuffer history cmd, M-p
(delete-selection-mode 1)            ; 

 
;;; 界面
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'wombat :no-confirm)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;; Font
(set-face-attribute 'default nil
                    :family "Maple Mono NF"
                    :height 130
                    :weight 'light)

;; highlight line
(use-package hl-line
  :ensure nil
  :config
  (set-face-attribute 'hl-line nil
                      :inherit nil
                      :foreground 'unspecified
                      :background "#303030"
                      :underline nil)
  (global-hl-line-mode 1))


;;; Minibuffer completion
(use-package vertico
  :demand t
  :config
  (vertico-mode 1))

;;; Tree-sitter
;; t = enable all available tree-sitter modes; missing grammars prompt for installation on first use.
(setopt treesit-enabled-modes t)

;;; Markdown
(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t))


;;; ZK — Org customization and knowledge workflow
(use-package zk
  :ensure nil
  :vc (:url "https://github.com/buenos-dan/zkel.git"
       :branch "main" :rev :newest :main-file "zk.el")
  :demand t
  :bind ("C-c n" . zk-menu)
  :config
  (zk-mode 1)
  (setq initial-buffer-choice #'zk-home))

;;; init.el ends here
(put 'narrow-to-page 'disabled nil)
