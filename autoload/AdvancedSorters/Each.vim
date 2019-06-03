" AdvancedSorters/Each.vim: Sort individual elements instead of full lines.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"   - AdvancedJoiners.vim plugin
"
" Copyright: (C) 2014-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.30.002	04-Jun-2019	Factor out generic s:SortEach().
"   1.10.001	06-Nov-2014	file creation

function! s:SortEach( bang, startLnum, endLnum, separatorPattern, joiner, sortArguments ) abort
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
	call ingo#err#Set('No WORDs to sort')
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
	    let l:joinNum = l:endLnum - ingo#range#NetStart(a:startLnum)
	    call AdvancedJoiners#QueryJoin#Join(1, l:joinNum, a:joiner)
	endif
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	silent! undo
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

function! AdvancedSorters#Each#Command( bang, startLnum, endLnum, arguments ) abort
endfunction
function! AdvancedSorters#Each#WORD( bang, startLnum, endLnum, arguments ) abort
    return s:SortEach(a:bang, a:startLnum, a:endLnum, '\s\+\|\s\+\n\s*\|\s*\n\s\+', "\n", a:arguments)
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
