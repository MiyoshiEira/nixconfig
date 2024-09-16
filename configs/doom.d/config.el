(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "CaskaydiaCove Nerd Font" :size 20))
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
(setq display-line-numbers-type t)
(setq fill-column 80)
(setq sentence-end-double-space nil)
(add-hook 'prog-mode-hook
(lambda () (add-hook 'before-save-hook 'delete-trailing-whitespace)))
(setq indent-tabs-mode nil)
(setq vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes")

(if (file-exists-p "~/.config/doom/private.el") (load! "~/.config/doom/private.el"))

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

(windmove-default-keybindings)
(setq org-support-shift-select 'always)

(add-hook 'org-shiftup-final-hook #'windmove-up)
(add-hook 'org-shiftleft-final-hook #'windmove-left)
(add-hook 'org-shiftdown-final-hook #'windmove-down)
(add-hook 'org-shiftright-final-hook #'windmove-right)

;;Mimic lvim behaviour
(after! evil
:config
(evil-ex-define-cmd "q" 'kill-this-buffer)
(evil-ex-define-cmd "wq" 'doom/save-and-kill-buffer))


;; Evil Window
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

(after! org
  (setq org-directory "~/.Org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "GYM(g)"            ; Things to accomplish at the gym
             "PROJ(p)"           ; A project that contains other tasks
             "VIDEO(v)"          ; Video assignments
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

(setq-default line-spacing 0)


;; Tangle on save
(defun tangle-on-save-org-mode-file ()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))
(add-hook 'after-save-hook 'tangle-on-save-org-mode-file)

;; Org Source blocks styling
(setq electric-indent-mode nil)
(setq org-src-window-setup 'current-window)
(set-popup-rule! "^\\*Org Src"
  :side 'top'
  :size 0.9)

(after! org
  (setq org-agenda-files '("~/.Org/agenda.org")))

(setq
   ;; org-fancy-priorities-list '("[A]" "[B]" "[C]")
   ;; org-fancy-priorities-list '("❗" "[B]" "[C]")
   org-fancy-priorities-list '("🟥" "🟧" "🟨")
   org-priority-faces
   '((?A :foreground "#ff6c6b" :weight bold)
     (?B :foreground "#98be65" :weight bold)
     (?C :foreground "#c678dd" :weight bold))
   org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))
