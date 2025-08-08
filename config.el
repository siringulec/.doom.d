;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Sirin Gulec"
      user-mail-address "siringulec1@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Some Extra Keybindings
;; source: spacemacs' better default layer
(setq tab-always-indent t)
(setq ns-auto-hide-menu-bar t)
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(defun backward-kill-word-or-region ()
  "Calls `kill-region' when a region is active and
            `backward-kill-word' otherwise."
  (interactive)
  (if (region-active-p)
      (call-interactively 'kill-region)
    (backward-kill-word 1)))

(global-set-key (kbd "C-w") 'backward-kill-word-or-region)

;; Use shell-like backspace C-h, rebind help to C-?
(keyboard-translate ?\C-h ?\C-?)
;; Fix emacs daemon
(add-hook 'server-after-make-frame-hook (lambda () (keyboard-translate ?\C-h ?\C-?)))
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-u") 'winner-undo)
(global-set-key (kbd "M-U") 'winner-redo)

;; Macos Key Bindings
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Expand Region
(use-package! expand-region
  :init
  (setq expand-region-fast-keys-enabled nil
        expand-region-subword-enabled t)
  :bind (("C-t" . er/expand-region)))

(use-package! consult
  :bind (("C-s" . consult-line)))

(use-package! lsp-pyright
  :hook (python-mode . lsp-deferred))

;; Multiple Cursors
(use-package! multiple-cursors
  :custom
  (mc/always-run-for-all t)
  :bind*
  (("C-M-n" . mc/mark-next-like-this)
   ("C-M-p" . mc/mark-previous-like-this)
   ("C-M-S-n" . mc/skip-to-next-like-this)
   ("C-M-S-p" . mc/skip-to-previous-like-this)
   ("C-S-n" . mc/unmark-previous-like-this)
   ("C-S-p" . mc/unmark-next-like-this)
   ("C-M-<mouse-1>" . mc/add-cursor-on-click)))

;; Turkish mode
(use-package! turkish)

;; Beacon package
(use-package! beacon
  :config
  (beacon-mode 1))

;; Git link package
(use-package! git-link
  :commands git-link)

(use-package! projectile
  :bind (("C-x f" . projectile-find-file)))

(use-package! lsp-mode
  :custom
  ;; (lsp-headerline-breadcrumb-enable nil)
  (lsp-diagnostics-provider :none) ;; To disable default lsp flycheck
  (lsp-file-watch-threshold 10000))

(use-package! org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n g" . org-roam-buffer-toggle)
         ("C-c n e" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-db-autosync-enable))

(defun sg/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package! org
  :ensure t
  :hook (org-mode . sg/org-mode-setup)
  :custom
  (org-confirm-babel-evaluate nil)
  (org-ellipsis " ↴") ;; ↴, ▼, ▶, ⤵
  (org-hide-emphasis-markers t)
  (org-agenda-files `(,(expand-file-name "agenda.org" org-directory)))
  :custom-face
  (org-document-title ((t (:font "Iosevka Aile" :height 1.3 :weight bold))))
  (org-level-7 ((t (:font "Iosevka Aile" :inherit outline-7 :height 1.1 :weight bold))))
  (org-level-6 ((t (:font "Iosevka Aile" :inherit outline-6 :height 1.1 :weight bold))))
  (org-level-5 ((t (:font "Iosevka Aile" :inherit outline-5 :height 1.1 :weight bold))))
  (org-level-4 ((t (:font "Iosevka Aile" :inherit outline-4 :height 1.15 :weight bold))))
  (org-level-3 ((t (:font "Iosevka Aile" :inherit outline-3 :height 1.2 :weight bold))))
  (org-level-2 ((t (:font "Iosevka Aile" :inherit outline-2 :height 1.25 :weight bold))))
  (org-level-1 ((t (:font "Iosevka Aile" :inherit outline-1 :height 1.3 :weight bold))))

  (variable-pitch ((t (:font "Iosevka Aile" :height 120))))
  (fixed-pitch ((t (:font "Iosevka Aile" :height 120))))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (org-block ((t (:foreground nil :inherit fixed-pitch))))
  ;; (org-block-begin-line ((t (:background "#242237"))))
  (org-table ((t (:inherit fixed-pitch))))
  (org-formula ((t (:inherit fixed-pitch))))
  (org-code ((t (:inherit (shadow fixed-pitch)))))
  (org-table ((t (:inherit (shadow fixed-pitch)))))
  ;; (org-indent ((t (:inherit (org-hide fixed-pitch)))))
  (org-verbatim ((t (:inherit (shadow fixed-pitch)))))
  (org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  (org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
  (org-checkbox ((t (:inherit (fixed-pitch org-todo))))))

(use-package! org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package! org-tempo
  :after org
  :config
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("cc" . "src c")))

(use-package! pyvenv
  :after python
  :config
  (defun sg/pyvenv-autoload ()
    "auto activate venv directory if exists"
    (interactive)
    (f-traverse-upwards (lambda (path)
                          (let ((venv-path (f-expand "venv" path)))
                            (when (f-exists? venv-path)
                              (pyvenv-activate venv-path))))))

  (add-hook 'python-mode-hook 'sg/pyvenv-autoload))


(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(use-package ob-sql-mode
  :ensure t)

(setq lsp-java-jdt-download-url  "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")

(use-package! vertico
  :bind ("C-M-y" . +vertico/project-search))

(setq lsp-csharp-root
      (lambda (_file)
        (or (locate-dominating-file default-directory ".sln")
            (locate-dominating-file default-directory ".csproj"))))
(setq lsp-disabled-clients '(omnisharp))
