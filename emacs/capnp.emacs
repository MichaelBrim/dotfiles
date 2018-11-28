;; ###### Cap'n Protocol highlighting ######
(add-to-list 'load-path "~/.emacs.d")
(require 'capnp-mode)
(add-to-list 'auto-mode-alist '("\\.capnp\\'" . capnp-mode))
