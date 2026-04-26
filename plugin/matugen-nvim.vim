if exists('g:loaded_matugen-nvim') | finish | endif

lua require("matugen-nvim").setup()

let s:save_cpo = &cpo
set cpo&vim

let g:loaded_matugen-nvim = 1

let &cpo = s:save_cpo
unlet s:save_cpo
