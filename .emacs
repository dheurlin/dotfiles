;;; Initialize melpa
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)



;;; Initialize evil mode
(add-to-list 'load-path "~/.emacs.d/evil")
(setq evil-want-integration nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))
(evil-mode 1)


;;; Remap C-u to C-f, so C-u can be used for evil-scroll-up
(define-key global-map (kbd "C-f") 'universal-argument)
(define-key universal-argument-map (kbd "C-u") nil)
(define-key universal-argument-map (kbd "C-f") 'universal-argument-more)
(define-key global-map (kbd "C-u") 'kill-whole-line)
(eval-after-load 'evil-maps
  '(progn
     (define-key evil-motion-state-map (kbd "C-f") nil)
     (define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)))


;;; Evil-mode plugins
(evil-commentary-mode)

(require 'evil-surround)
(global-evil-surround-mode 1)

;;; Enable evil-leader and set the leader key to ö
(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-leader "ö")


;;; Intialize exec-path-from-shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


;;; Disable scrollbars
(scroll-bar-mode -1)

;;; Scroll one line @ a time
;; (setq scroll-conservatively 1)


;;; Setup color theme ------------


;;; A function to toggle between light and dark color themes.
;;; Stolen from https://kylewm.com/2014/01/emacs-toggle-light-and-dark-themes
;;; And modified by yours truly because the fucking thing didn't work
(defcustom default-light-color-theme 'base16-solarized-light
  "default light theme")

(defcustom default-dark-color-theme 'base16-tomorrow-night
  "default dark theme")

(defun toggle-dark-light-theme ()
  (interactive)

    (let ((is-light (not (equal (member default-light-color-theme custom-enabled-themes) nil))))
     (dolist (theme custom-enabled-themes)
      (disable-theme theme))
    (load-theme (if is-light default-dark-color-theme default-light-color-theme) t)))

;;; Load dark theme by default 
(load-theme default-dark-color-theme t)

;;; Toggle themes with leader + t
(evil-leader/set-key "t" 'toggle-dark-light-theme)

;;; End of color theme ----------------------

;;; Use line numbers
(global-linum-mode t)


;;; Some buffer commands using the leader key
(evil-leader/set-key
  "bs" 'switch-to-buffer
  "l" 'next-buffer
  "h" 'previous-buffer
  "bq" 'kill-this-buffer)


;;; Functions to enable/disable menu bar
(defcustom menu-tool-enabled 1
  "Whether the menubar and toolbar are enabled")

(defun toggle-menu-toolbar ()

  (interactive)
  (if menu-tool-enabled
      (progn
	(menu-bar-mode -1)
	(tool-bar-mode -1)
	(setq menu-tool-enabled nil))
    (progn
      (menu-bar-mode 1)
      (tool-bar-mode 1)
      (setq menu-tool-enabled 1))))

(toggle-menu-toolbar) ;; disable by default

;;; Map to leader key
(evil-leader/set-key "mb" 'toggle-menu-toolbar)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3380a2766cf0590d50d6366c5a91e976bdc3c413df963a0ab9952314b4577299" "ef04dd1e33f7cbd5aa3187981b18652b8d5ac9e680997b45dc5d00443e6a46e3" "25c242b3c808f38b0389879b9cba325fb1fa81a0a5e61ac7cae8da9a32e2811b" default)))
 '(package-selected-packages
   (quote
    (evil-leader evil-surround evil-commentary exec-path-from-shell evil-collection base16-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))
