" AdvancedSorters/GetRanges.vim: Functions to obtain ranges.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2019-2021 Ingo Karkat
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

function! AdvancedSorters#GetRanges#FromMatch( startLnum, endLnum, expr )
    let l:ranges = []
    call cursor(a:startLnum, 1)
    while line('.') <= a:endLnum
	let l:startLnum = search(a:expr, 'cW', a:endLnum)
	if l:startLnum == 0
	    break
	endif
	let l:endLnum = search(a:expr, 'ceW', a:endLnum)
	if l:endLnum == 0
	    break
	endif

	call add(l:ranges, [l:startLnum, l:endLnum])

	if l:endLnum == a:endLnum
	    break
	else
	    call cursor(l:endLnum + 1, 1)
	endif
    endwhile
    return l:ranges
endfunction

function! AdvancedSorters#GetRanges#FromRange( startLnum, endLnum, expr )
    if empty(a:expr) | return [] | endif

    " With ranges, there can be overlapping regions. To emulate a fold-like
    " behavior (where folds can be contained in others), go through the list of
    " unique line numbers and the list of lines where ranges end, and build the
    " [startLnum, endLnum] list out of that.
    let [l:recordedLines, l:startLines, l:endLines, l:didClobberSearchHistory] = ingo#range#lines#Get(a:startLnum, a:endLnum, a:expr)
    let l:linesInRange = sort(ingo#list#transform#str2nr(keys(l:recordedLines)), 'ingo#collections#numsort')
    call ingo#compat#uniq(l:endLines)
    let l:ranges = []
    while ! empty(l:endLines)
	let l:startLnum = remove(l:linesInRange, 0)
	let l:endLnum = remove(l:endLines, 0)
	if l:startLnum < l:endLnum
	    call add(l:ranges, [l:startLnum, l:endLnum])
	    call remove(l:linesInRange, 0, index(l:linesInRange, l:endLnum))
	endif
    endwhile

    return l:ranges
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
