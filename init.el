(require 'package)
(setq package-archives
      '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
	("org"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
	("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

(package-initialize)
(show-paren-mode 1)
(column-number-mode 1)
(line-number-mode 1)
(set-face-attribute 'default nil :font "微软雅黑 16")

;;;(setq buffer-file-coding-system "UTF-8-dos")

;;;;在以上设置以后，安装以下的包，
;;;; M-x install.packages RET company
;;;; M-x install.packages RET helm
;;;; M-x install.packages RET ess
;;;; M-x install.packages RET yasnippet

;;;;;然后再加入下面的代码


;;;for cygwin
(setenv "PATH" (concat "c:/cygwin64/bin;" (getenv "PATH")))
(setq exec-path (cons "c:/cygwin64/bin/" exec-path))
(require 'cygwin-mount)
(cygwin-mount-activate)

(add-hook 'comint-output-filter-functions
    'shell-strip-ctrl-m nil t)
(add-hook 'comint-output-filter-functions
    'comint-watch-for-password-prompt nil t)
(setq explicit-shell-file-name "bash.exe")
;; For subprocesses invoked via the shell
;; (e.g., "shell -c command")
(setq shell-file-name explicit-shell-file-name)


;;;;;;;;for ssh within emacs  under windows
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "fakecygpty")
(require 'fakecygpty)
(fakecygpty-activate)
(setq fakecygpty-program "/usr/bin/fakecygpty.exe")
(setq fakecygpty-qkill-program "/usr/bin/qkill.exe")

;;;;ess
(add-to-list 'load-path "~/.emacs.d/ess/lisp")
(load "ess-site")
(require 'ess-site)

(setq-default inferior-R-program-name "C:/R/R-3.4.1/bin/x64/Rterm.exe")

(setq ess-ask-for-ess-directory nil)
(setq ess-directory "c:/xuyang/myR")

(setq inferior-ess-same-window nil)

(setq inferior-ess-font-lock-keywords t)

(setq ess-mode-font-lock-keywords t)

(setq ess-trans-font-lock-keywords t)




;;;;;helm
(add-to-list 'load-path "~/xuyang/.emacs.d/elpa")
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-z") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)


(add-to-list 'load-path "~/xuyang/.emacs.d/elpa")
(require 'yasnippet)
;;;;;;;(setq yas-snippet-dirs '(/yasnippet/snippets"))
(yas-global-mode 1)


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (move-beginning-of-line 1)
)
;;(global-set-key (kbd "C-c C-v") 'duplicate-line)

(defun select-multi-line (my-begin-line my-end-line)
  "select multiple lines by line number"
  (interactive "nbegin line number to select:\nn(%s-):end line number:")
  (let ((cur-line (line-number-at-pos)))
       (beginning-of-line (+ 1 (- my-begin-line cur-line)))
       (set-mark (point))
       ;;(make-marker)
       (beginning-of-line (+ 2 (- my-end-line my-begin-line)))))
       ;;(kill-region (mark) (point))
       ;;(yank)
       ;;(message "line %d - %d is copied" my-begin-line my-end-line)))

(global-set-key (kbd "C-c m") 'select-multi-line)

(defun paste-lines (target-line)
   "paste multiple lines to target line"
  (interactive "ntarget line to paste:")
  (let ((cur-line (line-number-at-pos)))
       (beginning-of-line (+ 1 (- target-line cur-line)))
       (yank)))

;;(global-set-key (kbd "C-c C-m") 'paste-lines)
  
(defun comment-whole-line (&optional arg)
  "comment the line"
  (interactive "P")
  (let ((beg (line-beginning-position))
	(end (+ 1 (line-end-position arg))))
    (comment-or-uncomment-region beg end))
  )

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position))
	(end (line-end-position arg)))
    (copy-region-as-kill beg end))
  )


(defun copy-word (&optional arg)
  "Copy words at point"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point)))
	(end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end))
  )


(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point)))
	(end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end))
  )

(global-set-key (kbd "C-c l") 'copy-line)
(global-set-key (kbd "C-c w") 'copy-word)
(global-set-key (kbd "C-c p") 'copy-paragraph)
					; C-cc is for og-capture
					;(global-set-key (kbd "C-c c") 'comment-whole-line)


(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (R . t)
   (python . t)
   (latex . t)
   (ditaa . t)
   ))

(require 'ox-latex)
(require 'ox-html)

(setq org-html-table-default-attributes
      (list  :border "2" :rules "all" :frame "border"
	     :align "center"
	     :cellspacing "0"
	     :cellpadding "6"))
(setq org-html-table-caption-above nil)

(add-hook 'org-mode-hook (lambda () 
			   (add-to-list 'org-latex-classes
					'("ctexart"
					  "\\documentclass{ctexart}"
					  ("\\section{%s}" . "\\section*{%s}")
					  ("\\subsection{%s}" . "\\subsection*{%s}")
					  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
					  ("\\paragraph{%s}" . "\\paragraph*{%s}")
					  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
			   (add-to-list 'org-latex-classes
					'("ctexbook"
					  "\\documentclass{ctexbook}"
					  ("\\part{%s}" . "\\part*{%s}")
					  ("\\chapter{%s}" . "\\chapter*{%s}")
					  ("\\section{%s}" . "\\section*{%s}")
					  ("\\subsection{%s}" . "\\subsection*{%s}")
					  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
					  ))))


(setq tramp-default-method "plink")

(setq save-buffer-coding-system "utf-8-dos")

(defun scp-to-wp (orgfile htmlfile)
  ;;;convert the coding system and scp it

;;;  (fakecygpty-activate)
;;;  (if (string= "chinese-gbk-dos" buffer-file-coding-system)
;;;      (shell-command "~/blog/convSync.sh")
    (shell-command "~/blog/msync.sh"))


(setq org-publish-after-publishing-hook 'scp-to-wp)

(setq org-publish-project-alist
      '(("org"
	 :base-directory "~/blog"
	 :base-extension "org"
      	 :publishing-directory "~/blog/html"
	 ;;;;:publishing-directory "/ssh:xuyang@wp.bagualu.net:/var/www/bagualu/markdown/"
	 :section-numbers t
	 :with-toc t
	 :body-only t
	 :publishing-function org-html-publish-to-html
	 )

	("images"
	 :base-directory "~/blog/rfigures"
	 :base-extension "png"
	 :publishing-directory "~/blog/rfigures"
	 ;;;;:publishing-directory "/ssh:xuyang@wp.bagualu.net:/var/www/bagualu/archives/rfigures/"
	 :publishing-function org-publish-attachment)
	))

(setq org-export-default-language "zh-CN")

;;;;;;;; for magit
(add-to-list 'exec-path "C:/Program Files (x86)/Git/cmd")

(defun mpub (&optional arg)
  "pub current org file to blog"
  (interactive "P")
  (org-publish-current-file)
  (shell-command "~/blog/msync.sh"))

(global-set-key (kbd "C-x p") 'mpub)

(add-to-list 'exec-path "C:/sbcl")
(setq inferior-lisp-program "sbcl") 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (slime cygwin-mount yasnippet helm company magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
