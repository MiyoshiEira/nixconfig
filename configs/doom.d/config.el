(setq user-full-name "MiyoshiEira"
      user-mail-address "eira@miyoshi.app")
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 20))
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(customize-set-variable 'fill-column 80)
(customize-set-variable 'sentence-end-double-space nil)
(add-hook 'prog-mode-hook
(lambda () (add-hook 'before-save-hook 'delete-trailing-whitespace)))
(customize-set-variable 'indent-tabs-mode nil)

(require 'mu4e)
  :ensure nil
  :config
(after! mu4e
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")
  (setq message-confirm-send t)
  (setq mu4e-compose-context-policy 'ask-if-none)
  (setq mu4e-compose-format-flowed t)
  (setq mu4e-context-policy 'ask-if-none)
  (setq mu4e-date-format "%d-%m-%Y")
  (setq mu4e-use-fancy-chars t)
  (setq mu4e-view-show-addresses t)
  (setq mu4e-view-show-images t)
  (if (file-exists-p "~/.dotfiles/configs/doom.d/private.el") (load! "~/.dotfiles/configs/doom.d/private.el"))


  (defun no-auto-fill ()
      (auto-fill-mode -1))

  (defun no-org-msg-mode ()
      (org-msg-mode 0))

  (add-hook 'mu4e-compose-mode-hook #'no-auto-fill)
  (add-hook 'mu4e-compose-pre-hook #'no-org-msg-mode)

  (mu4e--start) ;; start mu4e silently
)

(setq wl-copy-process nil)
(defun wl-copy (text)
(setq wl-copy-process (make-process
:name "wl-copy"
:buffer nil
:command '("wl-copy" "-f" "-n")
:connection-type 'pipe
:noquery t))
(process-send-string wl-copy-process text)
(process-send-eof wl-copy-process))
(defun wl-paste ()
(if (and wl-copy-process (process-live-p wl-copy-process))
nil
(shell-command-to-string "wl-paste -n | tr -d \r")))
(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)

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

(windmove-default-keybindings)
(customize-set-variable 'org-support-shift-select 'always)

(add-hook 'org-shiftup-final-hook #'windmove-up)
(add-hook 'org-shiftleft-final-hook #'windmove-left)
(add-hook 'org-shiftdown-final-hook #'windmove-down)
(add-hook 'org-shiftright-final-hook #'windmove-right)

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
