" AdvancedSorters.vim: Sorting of certain areas or by special needs.
"
" DEPENDENCIES:
"   - AdvancedSorters/Expr.vim autoload script
"   - AdvancedSorters/Ranges.vim autoload script
"   - ingo/compat.vim autoload script
"   - ingo/err.vim autoload script
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	08-Jun-2014	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AdvancedSorters') || (v:version < 700)
    finish
endif
let g:loaded_AdvancedSorters = 1

command! -bang -range=% -nargs=* SortUnfolded call setline(<line1>, getline(<line1>)) | if ! AdvancedSorters#Ranges#Unfolded('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif
command! -bang -range=% -nargs=1 -complete=expression SortByExpr <line1>,<line2>call AdvancedSorters#Expr#Sort(<bang>0, <q-args>)
command! -bang -range=% SortByCharLength <line1>,<line2>call AdvancedSorters#Expr#Sort(<bang>0, function('ingo#compat#strchars'))
command! -bang -range=% SortByWidth <line1>,<line2>call AdvancedSorters#Expr#Sort(<bang>0, function('ingo#compat#strdisplaywidth'))

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
