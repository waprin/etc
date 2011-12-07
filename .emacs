

;; john prefers spaces
(setq-default indent-tabs-mode nil)

;; compile key binding
(global-set-key (kbd "C-c c") 'compile)
;; goto line key binding
(global-set-key (kbd "C-c g") 'goto-line)

(add-hook 'c++-mode-common-hook
          (lambda () (subword-mode 1)))

;; normal indenting and camelcaseo
(setq c-default-style "bsd"
      c-basic-offset 4)

;; make emacs pretty
(require 'color-theme)
(color-theme-initialize)
(color-theme-jsc-dark)

;; get rid of menus
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode)(menu-bar-mode -1))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; rename file and buffer
(defun rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message "File '%s' successfully renamed to '%s'" name (file-name-nondirectory new-name))))))))

;; move backups and autosaves out of the way
(custom-set-variables
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist'((".*" . "~/.emacs.d/backups/"))))
(make-directory "~/.emacs.d/autosaves/" t)


(load-file "~/Downloads/cedet-1.0/common/cedet.el")
(global-ede-mode 'nil)

(semantic-load-enable-excessive-code-helpers)
(require 'semantic-ia)
(require 'semantic-gcc)
(semantic-add-system-include "/usr/local/include/boost/")
(semantic-add-system-include "/home/brin/selerity/cpp/")
(require 'semanticdb)
(global-semanticdb-minor-mode 1)

(defun my-cedet-hook()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "\C-c+" 'semantic-tag-folding-show-block)
  (local-set-key "\C-c-" 'semantic-tag-folding-fold-block)
  (local-set-key "\C-c\C-c+" 'semantic-tag-folding-show-all)
  (local-set-key "\C-c\C-c-" 'semantic-tag-folding-fold-all)
  )
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(global-semantic-tag-folding-mode 1)
(require 'eassist)
(defun alexott/c-mode-cedet-hook() 
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
)
(add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)


(require 'semanticdb-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
(require 'semanticdb-ectag)
(semantic-load-enable-primary-exuberent-ctags-support)
;(global-semantic-idle-tag-highlight-mode 1)
                      
(put 'narrow-to-region 'disabled nil)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
;(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

