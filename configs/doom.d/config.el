;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "MiyoshiEira"
      user-mail-address "eira@miyoshi.app")
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 20))
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq x-select-enable-clipboard t)
(require 'simpleclip)
(simpleclip-mode 1)

(defun org-jekyll-new-post ()
  (interactive)
  (setq new-blog-post-title (read-from-minibuffer "Post name: "))
  (setq new-blog-post-date (format-time-string "%Y-%m-%d" (date-to-time (org-read-date))))
  (setq new-blog-post-slug (downcase (replace-regexp-in-string "[^[:alpha:][:digit:]_-]" "" (string-replace " " "-" new-blog-post-title))))
  (setq new-blog-post-file (concat (projectile-project-root) "org/_posts/"  new-blog-post-date "-" new-blog-post-slug ".org"))
  (let ((org-capture-templates
        `(("p" "New Jekyll blog post" plain (file new-blog-post-file)
           ,(concat "#+title: " new-blog-post-title "\n#+options: toc:nil num:nil\n#+begin_export html\n---\nlayout: post\ntitle: " new-blog-post-title "\nexcerpt: %?\ntags: \npermalink: " new-blog-post-date "-" new-blog-post-slug "\n---\n#+end_export\n\n#+attr_html: :alt " new-blog-post-title " :align center\n[[../assets/" new-blog-post-date "-" new-blog-post-slug ".png]]")))
   )) (org-capture))
)

(defun org-jekyll-rename-post ()
  (interactive)
  (setq new-blog-post-title (read-from-minibuffer "Post name: "))
  (setq new-blog-post-date (format-time-string "%Y-%m-%d" (date-to-time (org-read-date))))
  (setq new-blog-post-slug (downcase (replace-regexp-in-string "[^[:alpha:][:digit:]_-]" "" (string-replace " " "-" new-blog-post-title))))
  (org-roam-set-keyword "title" new-blog-post-title)
  (replace-regexp "permalink: .*\n" (concat "permalink: " new-blog-post-date "-" new-blog-post-slug "\n") nil (point-min) (point-max))
  (replace-regexp "title: .*\n" (concat "title: " new-blog-post-title "\n") nil (point-min) (point-max))
  (setq prev-blog-post-filename-base (file-name-base (buffer-file-name)))
  (doom/move-this-file (concat new-blog-post-date "-" new-blog-post-slug ".org"))
  (shell-command (concat "sed -i s/" prev-blog-post-filename-base "/" (file-name-base (buffer-file-name)) "/g *.org") nil)
  (replace-regexp prev-blog-post-filename-base (file-name-base (buffer-file-name)) nil (point-min) (point-max))
  (save-buffer)
)

(map! :leader
      :prefix ("N")

      :desc "New blog post"
      "p" #'org-jekyll-new-post

      :desc "Rename or redate blog post and update links accordingly"
      "e" #'org-jekyll-rename-post
)

(bind-key* "C-j" #'evil-window-down)
(bind-key* "C-k" #'evil-window-up)
(bind-key* "C-h" #'evil-window-left)
(bind-key* "C-l" #'evil-window-right)
(bind-key* "C-q" #'evil-window-delete)

;;Buffer management
(bind-key* "<mouse-9>" #'next-buffer)
(bind-key* "<mouse-8>" #'previous-buffer)

;; GC
(add-hook 'after-init-hook
          #'(lambda ()
              (setq gc-cons-threshold (* 100 1024 1024))))
(add-hook 'focus-out-hook 'garbage-collect)
(run-with-idle-timer 5 t 'garbage-collect)

;; Autoupdate buffer on filechange
(setq global-auto-revert-mode nil)
(setq auto-revert-use-notify t)

(setq org-directory "~/.Org")

(set-company-backend! 'org-mode nil)

(setq org-startup-with-inline-images t
      org-image-actual-width nil)

;; Frame borders and dividers
(modify-all-frames-parameters
 '((right-divider-width . 5)
   (internal-border-width . 5)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "...")

(setq-default line-spacing 0)

;; Tangle on save
(defun tangle-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))
(add-hook 'after-save-hook 'tangle-on-save-org-mode-file)

;; Org Source blocks styling
(setq electric-indent-mode nil)
(setq org-src-window-setup 'current-window)
(set-popup-rule! "^\\*Org Src"
  :side 'top'
  :size 0.9)

;; Org Roam Config
(require 'org-roam)
