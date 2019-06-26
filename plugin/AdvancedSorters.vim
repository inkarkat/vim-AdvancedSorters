" AdvancedSorters.vim: Sorting of certain areas or by special needs.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2014-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.30.007	04-Jun-2019	Add :SortEach generalization of :SortWORDs.
"   1.30.006	16-Jun-2017	CHG: Rename :Uniq to :UniqAny and add
"				:UniqSubsequent variant.
"   1.20.005	03-Feb-2015	Add :Uniq command.
"   1.10.004	06-Nov-2014	Add :SortWORDs command.
"   1.00.003	10-Jun-2014	Add :SortRangesByRange command.
"				Add :SortByExprUnique variant.
"	002	08-Jun-2014	Have :SortBy... commands check for buffer
"				modifiablity and handle errors, too.
"	001	08-Jun-2014	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_AdvancedSorters') || (v:version < 700)
    finish
endif
let g:loaded_AdvancedSorters = 1
let s:save_cpo = &cpo
set cpo&vim

command! -bang -range=% -nargs=* SortVisible
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#Visible('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=+ SortRangesByHeader
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#ByHeader('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=+ SortRangesByMatch
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#ByMatch('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=+ SortRangesByRange
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Ranges#ByRange('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif


command! -bang -range=% -nargs=1 -complete=expression SortByExpr
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 0, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% -nargs=1 -complete=expression SortByExprUnique
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 1, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range=% SortByCharLength
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 0, function('ingo#compat#strchars')) | echoerr ingo#err#Get() | endif

command! -bang -range=% SortByWidth
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Expr#Sort(<line1>, <line2>, <bang>0, 0, function('ingo#compat#strdisplaywidth')) | echoerr ingo#err#Get() | endif

command! -bang -range -nargs=* SortEach
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Each#Command('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -bang -range -nargs=* SortWORDs
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Each#WORD('<bang>', <line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

command! -range=% -nargs=* UniqAny
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Uniq#UniqAny(<line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif
command! -range=% -nargs=* UniqSubsequent
\   call setline(<line1>, getline(<line1>)) |
\   if ! AdvancedSorters#Uniq#UniqSubsequent(<line1>, <line2>, <q-args>) | echoerr ingo#err#Get() | endif

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
