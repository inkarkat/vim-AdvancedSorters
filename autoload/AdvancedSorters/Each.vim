" AdvancedSorters/Each.vim: Sort individual elements instead of full lines.
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
"   1.30.002	04-Jun-2019	Factor out generic s:SortEach().
"				Implement :SortEach via
"				AdvancedSorters#Each#Command().
"   1.10.001	06-Nov-2014	file creation
let s:save_cpo = &cpo
set cpo&vim

function! s:SortEach( what, bang, startLnum, endLnum, separatorPattern, joiner, sortArguments ) abort
    " Unjoin lines, delete indent and trailing whitespace.
    execute printf('silent %d,%dsubstitute/%s/\r/g', a:startLnum, a:endLnum, escape(a:separatorPattern, '/'))
    let [l:endLnum, l:lineNum] = [line("']"), line('$')]

    " Remove completely empty lines.
    execute printf('silent %d,%dglobal/^$/delete _', a:startLnum, l:endLnum)
    call histdel('search', -1)

    let l:deletedLineNum = l:lineNum - line('$')
    let l:endLnum -= l:deletedLineNum
    if l:endLnum < a:startLnum
	silent! undo
	call ingo#err#Set(printf('No %s to sort', a:what))
	return 0
    endif

    try
	let l:lineNum = line('$')
	execute printf('silent %d,%dsort%s %s', a:startLnum, l:endLnum, a:bang, a:sortArguments)
	let l:duplicatedNum = l:lineNum - line('$')
	let l:endLnum -= l:duplicatedNum

	if a:joiner ==# "\n"
	    execute printf('silent %d,%djoin', a:startLnum, l:endLnum)
	else
	    call ingo#join#Range(1, ingo#range#NetStart(a:startLnum), l:endLnum, a:joiner)
	endif
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	silent! undo
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

function! s:GetFirstDelimiter( startLnum, endLnum, separatorPattern ) abort
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]
    return matchstr(join(getline(l:startLnum, l:endLnum), "\n"), a:separatorPattern)
endfunction
function! AdvancedSorters#Each#Command( bang, startLnum, endLnum, arguments ) abort
    let [l:separator, l:separatorPattern, l:joiner, l:sortArgs] = ingo#cmdargs#substitute#Parse(a:arguments,
    \   {'flagsExpr': AdvancedSorters#Ranges#GetSortArgumentsExpr(5, '*'), 'emptyFlags': '', 'emptyReplacement': '', 'isAllowLoneFlags': 0}
    \)
    let l:separatorPattern = (empty(l:separatorPattern) ?
    \   ingo#escape#Unescape(@/, '/') :
    \   ingo#escape#Unescape(l:separatorPattern, l:separator)
    \)
    let l:joiner = (empty(l:joiner) ?
    \   s:GetFirstDelimiter(a:startLnum, a:endLnum, l:separatorPattern) :
    \   ingo#escape#Unescape(l:joiner, l:separator)
    \)

    return s:SortEach('elements', a:bang, a:startLnum, a:endLnum, l:separatorPattern, l:joiner, l:sortArgs)
endfunction

function! AdvancedSorters#Each#WORD( bang, startLnum, endLnum, arguments ) abort
    return s:SortEach('WORDs', a:bang, a:startLnum, a:endLnum, '\s\+\|\s\+\n\s*\|\s*\n\s\+', "\n", a:arguments)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
