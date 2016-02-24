" AdvancedSorters/Words.vim: Sort individual WORDs instead of full lines.
"
" DEPENDENCIES:
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.10.001	06-Nov-2014	file creation

function! AdvancedSorters#Words#Sort( bang, startLnum, endLnum, arguments )
    " Join lines, delete indent and trailing whitespace.
    execute printf('silent %d,%dsubstitute/\s\+\|\s\+\n\s*\|\s*\n\s\+/\r/g', a:startLnum, a:endLnum)
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
	execute printf("silent %d,%dsort%s %s", a:startLnum, l:endLnum, a:bang, a:arguments)
	let l:duplicatedNum = l:lineNum - line('$')
	let l:endLnum -= l:duplicatedNum

	execute printf("silent %d,%djoin", a:startLnum, l:endLnum)
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	silent! undo
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
