" AdvancedSorters/GetRanges.vim: Functions to obtain ranges.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

function! AdvancedSorters#GetRanges#FromHeader( startLnum, endLnum, expr ) abort
    let l:headerLnums = []
    call cursor(a:startLnum, 1)
    while line('.') <= a:endLnum
	let l:lnum = search(a:expr, 'cW', a:endLnum)
	if l:lnum == 0
	    break
	endif

	call add(l:headerLnums, l:lnum)

	if l:lnum == a:endLnum
	    break
	else
	    call cursor(l:lnum + 1, 1)
	endif
    endwhile

    let l:ranges = []
    for l:i in range(len(l:headerLnums))
	call add(l:ranges, [l:headerLnums[l:i], get(l:headerLnums,l:i + 1, a:endLnum + 1) - 1])
    endfor
    return l:ranges
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
