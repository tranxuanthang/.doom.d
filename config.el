;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tran Xuan Thang"
      user-mail-address "tranthang.yb@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Liberation Mono" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-city-lights)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;
;; Fcitx
;;

;; (use-package! fcitx
;;   :config
;;   (fcitx-default-setup))

;;
;; Thang's web-mode config
;;

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-style-padding 0)
(setq web-mode-script-padding 0)

;;
;; Thang's lsp-mode config
;;

(setq lsp-enable-file-watchers t)
(setq lsp-file-watch-threshold 1000)

;;
;; editorconfig config
;;

(add-hook
 'editorconfig-after-apply-functions
 (lambda
   (props)
   (setq web-mode-style-padding 0)
   (setq web-mode-script-padding 0)))

;;
;; Vue web-mode flycheck
;;

(use-package! flycheck
  :config
  (define-derived-mode vue-mode web-mode "Vue mode")
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  (flycheck-add-mode 'javascript-eslint 'vue-mode)
  (flycheck-add-mode 'css-stylelint 'vue-mode))

;;
;; Thang's Keybindings
;;

(map! :leader
      :desc "Switch to last buffer" "TAB" #'evil-switch-to-windows-last-buffer
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"     #'evil-window-up
      "<right>"     #'evil-window-right
      :desc "M-x" "SPC" #'execute-extended-command
      :desc "Run term" "'" #'multi-term
      :desc "Search project" "/" #'+default/search-project
      (:when (featurep! :editor snippets)
        (:prefix-map ("S" . "snippets")))
      (:when (featurep! :ui workspaces)
        (:prefix-map ("l" . "workspace"))))

(map! :map evil-window-map
      "<left>"     #'evil-window-left
      "<down>"     #'evil-window-down
      "<up>"     #'evil-window-up
      "<right>"     #'evil-window-right
      "/" #'evil-window-vsplit
      "d" #'evil-window-delete)

;;
;; Fullscreen
;;

(add-to-list 'default-frame-alist '(fullscreen . maximized))
