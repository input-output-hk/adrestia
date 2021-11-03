# Emacs setup

Here are some notes about setting up your Emacs for `cardano-wallet`
development.

## General Haskell editing

Start off by applying repo default settings with [editorconfig](https://editorconfig.org).

```lisp
(use-package editorconfig
  :delight
  :config
  (editorconfig-mode 1))
```

Since Emacs 26, there is a built-in mode to show the column limit,
which you must respect:

```lisp
(defun rvl/display-fill-column ()
  (setq display-fill-column-indicator 1)
  (display-fill-column-indicator-mode))
```

Add some custom font locking to make `fixme` and `TODO` things stand
out:

```lisp
(defun rvl/font-lock-keywords ()
  "Configure font-lock-mode to highlight TODO/fixme tags"
  (font-lock-add-keywords
    nil
    '(("\\<\\(fixme\\|TODO\\|BUG\\|XXX\\):" 1 font-lock-warning-face t))))
```

## Basic Haskell Mode

See the
[`haskell-mode`](http://haskell.github.io/haskell-mode/manual/latest/)
docs for all of the options.

```lisp
(use-package haskell-mode
  :delight "λ"
  :after haskell-font-lock

  :config
  ;; Flycheck is usually slow for Haskell stuff - only run on save.
  (setq flycheck-check-syntax-automatically '(mode-enabled save))

  :init
  (defun rvl/enable-subword-mode ()
    "Navigate within identifier names"
    (subword-mode +1))

  (defun rvl/stylish-on-save ()
    (setq haskell-stylish-on-save t)

  :hook ((haskell-mode . rvl/display-fill-column)
         (haskell-mode . rvl/stylish-on-save)
         (haskell-mode . rvl/font-lock-keywords)
         (haskell-mode . direnv-update-environment)

         (haskell-mode . rvl/enable-subword-mode)
         (haskell-mode . haskell-indentation-mode)
         (haskell-mode . imenu-add-menubar-index))

  :bind (:map haskell-mode-map
        ("C-c C-c" . haskell-process-cabal-build)
        ("C-c c" . haskell-process-cabal)
        ("C-c v c" . haskell-cabal-visit-file)
        ("C-c i" . haskell-navigate-imports)

        ;; YMMV with haskell-interactive-mode - LSP is a better bet
        ("C-`" . haskell-interactive-bring)
        ("C-c C-l" . haskell-process-load-file)
        ("C-c C-t" . haskell-process-do-type)
        ("C-c C-i" . haskell-process-do-info)
        ("C-c C-k" . haskell-interactive-mode-clear)

        ;; These are usually set by default, but just make sure:
        ("M-." . xref-find-definitions)
        ("M-," . xref-pop-marker-stack)
        ("M-," . xref-find-references)

        :map haskell-cabal-mode-map
        ("C-c C-c" . haskell-process-cabal-build)
        ("C-c c" . haskell-process-cabal))

  :custom
  (haskell-process-log t))
```

## Haskell Language Server

This is now the best way of getting IDE features.

```lisp
(use-package lsp-haskell
  :after (haskell-mode lsp-mode)
  :config
  ;; Comment/uncomment this line to see interactions between lsp client/server.
  ;; (setq lsp-log-io t)
  :custom
  ;(lsp-haskell-process-args-hie '("-d" "-l" "/tmp/hie.log"))
  ;(lsp-haskell-server-args ())
  (lsp-haskell-server-path "haskell-language-server"))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory t)
  (lsp-ui-doc-enable t)
  ;; You might want this:
  ; (lsp-ui-doc-show-with-cursor nil)
  ;; Also this because isearch gets broken otherwise
  ; (lsp-ui-doc-show-with-mouse nil)
  (lsp-ui-doc-position 'top)
  (lsp-ui-imenu-window-width 20))

(use-package lsp-mode
  :commands lsp
  :init
  ;; You need to restart emacs for keymap prefix to take effect
  ; (setq lsp-keymap-prefix "M-L")

  :config
  ;; so that dir-locals have effect:
  ;;   https://github.com/emacs-lsp/lsp-mode/issues/405
  (add-hook 'hack-local-variables-hook (lambda () (when lsp-mode (lsp))))

  :hook ((haskell-mode . lsp-deferred)
         (haskell-literate-mode . lsp-deferred)
         (lsp-managed-mode . lsp-modeline-diagnostics-mode)
         ;; if you want which-key integration
         ; (lsp-mode . (lambda () (lsp-enable-which-key-integration t)))
         )

  :custom
  (lsp-progress-via-spinner nil) ;; spinner seems to cause problems
  (lsp-restart 'ignore)
  (lsp-keep-workspace-alive nil)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(symbols))
  (lsp-lens-enable t)
  (lsp-enable-snippet nil)

  ;; :global/:workspace/:file
  (lsp-modeline-diagnostics-scope :workspace)
  (lsp-file-watch-threshold 2000)
  ; (setq lsp-idle-delay 0.500)
  (lsp-completion-provider :capf))

(use-package lsp-lens :delight)
```

### Performance tweaks

These settings are for reducing `emacs-lsp` slowness. See
[lsp-mode Performance](https://emacs-lsp.github.io/lsp-mode/page/performance/)
for more details.

```lisp
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq gc-cons-threshold 80000000)
```

## Flycheck and completion

```lisp
;; Configure flycheck, but don't enable globally.
(use-package flycheck
  :delight
  :config
  ;; set the error window size
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window
                  display-buffer-in-side-window)
                 (side            . bottom)
                 (reusable-frames . visible)
                 (window-height   . 0.2))))

;; Enable completion globally
(use-package company
  :delight
  :config
  ;; company completion everywhere, except where it's annoying.
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-global-modes '(not erc-mode))
  ;; Selectively enable idle popup of completions.
  (setq company-idle-delay
        (lambda ()
          (if (or (bound-and-true-p message-mode) (bound-and-true-p prog-mode))
              0.2 nil))))

```

## Direnv support in Emacs

You definitely want direnv support in Emacs if using Nix.

```lisp
(use-package direnv
  :config
  ;; enable globally
  (direnv-mode)
  ;; exceptions
  ; (add-to-list 'direnv-non-file-modes 'foobar-mode)

  ;; nix-shells make too much spam -- hide
  (setq direnv-always-show-summary nil)

  :hook
  ;; ensure direnv updates before flycheck and lsp
  ;; https://github.com/wbolster/emacs-direnv/issues/17
  (flycheck-before-syntax-check . direnv-update-environment)
  (lsp-before-open-hook . direnv-update-environment)

  :custom
  ;; quieten logging
  (warning-suppress-types '((direnv))))
```

## `nix-direnv` for development shells

Now finally, make sure you have
[`nix-direnv`](https://github.com/nix-community/nix-direnv) installed
and enabled for your repo working directories.

Direnv integration will ensure that all build tools in `shell.nix` are
available for Emacs to use. Importantly, this includes
`haskell-language-server`.
