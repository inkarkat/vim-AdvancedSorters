" AdvancedSorters/Expr.vim: Sorting by a custom expression.
"
" DEPENDENCIES:
"   - ingo/actions.vim autoload script
"   - ingo/err.vim autoload script
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.003	10-Jun-2014	Implement unique sorting via additional
"				a:isUnique flag.
"	002	08-Jun-2014	Catch exceptions to avoid that the same
"				expression error is printed for all lines.
"				Silence the substitution messages.
"				Pass in the range instead of using
"				function-range to allow returning the success.
"				Undo the (first) substitution (assuming it
"				caused the exception) on failure. Else, the
"				entire range will be reduced to empty lines when
"				there's a problem with the passed expression.
"	001	08-Jun-2014	file creation

function! AdvancedSorters#Expr#Sort( startLnum, endLnum, isReverse, isUnique, expr )
    try
	if type(a:expr) == type(function('tr'))
	    silent execute a:startLnum . ',' . a:endLnum . 'substitute/^.*$/\= call(' . string(a:expr) . ',[submatch(0)]) . " " . submatch(0)/'
	else
	    silent execute a:startLnum . ',' . a:endLnum . 'substitute/^.*$/\=' . substitute(a:expr, '\C' . ingo#actions#GetValExpr(), 'submatch(0)', 'g') . ' . " " . submatch(0)/'
	endif
	execute a:startLnum . ',' . a:endLnum . 'sort' . (a:isReverse ? '!' : '') 'n'

	let l:lastLnum = line('$')  " When the a:isUnique flag is passed, duplicate lines reduce the number of lines.
	let l:sortOffset = 0        " Account for the reduced end line number when undoing the numbering.
	if a:isUnique
	    silent execute (a:startLnum + 1) . ',' . a:endLnum . 'g/^/if matchstr(getline(line(".") - 1), "^\\d\\+ ") ==# matchstr(getline("."), "^\\d\\+ ") | silent delete _ | endif'
	    let l:sortOffset = line('$') - l:lastLnum
	endif

	silent execute a:startLnum . ',' . (a:endLnum + l:sortOffset) . 'substitute/^\d\+ //'
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	silent! undo
	return 0
    finally
	call histdel('search', -1)
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
