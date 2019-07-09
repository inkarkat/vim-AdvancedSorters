" AdvancedSorters/Reorder.vim: Reordering of whole ranges as one unit.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
let s:save_cpo = &cpo
set cpo&vim

function! s:GetLinesFromRanges( ranges ) abort
    return map(a:ranges, 'v:val[0] == v:val[1] ? getline(v:val[0]) : join(getline(v:val[0], v:val[1]), "\n")')
endfunction
function! s:ReorderLines( lines, expr ) abort
    return ingo#actions#EvaluateWithVal(a:expr, a:lines)
endfunction

function! s:GetNextStartLnum( ranges ) abort
    return get(a:ranges, 0, [0x7FFFFFFF, 0x7FFFFFFF])[0]
endfunction
function! s:AddIndividualLines( startLnum, endLnum, ranges ) abort
    let l:lnum = a:startLnum
    let l:result = []
    while l:lnum <= a:endLnum
	if s:GetNextStartLnum(a:ranges) == l:lnum
	    let l:range = remove(a:ranges, 0)
	    call add(l:result, l:range)
	    let l:lnum = l:range[1] + 1
	else
	    call add(l:result, [l:lnum, l:lnum])
	    let l:lnum += 1
	endif
    endwhile
    return l:result
endfunction

function! s:Weave( modifiedRanges, modifiedLines, otherRanges ) abort
    let l:result = []
    while ! empty(a:modifiedRanges) || ! empty(a:otherRanges)
	if s:GetNextStartLnum(a:modifiedRanges) < s:GetNextStartLnum(a:otherRanges)
	    call remove(a:modifiedRanges, 0)
	    call add(l:result, remove(a:modifiedLines, 0))
	else
	    let l:range = remove(a:otherRanges, 0)
	    call add(l:result, join(getline(l:range[0], l:range[1]), "\n"))
	endif
    endwhile
    return l:result
endfunction

function! AdvancedSorters#Reorder#Visible( startLnum, endLnum, arguments ) abort
    try
	let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]
	let l:closedFolds = ingo#folds#GetClosedFolds(l:startLnum, l:endLnum)
	let l:ranges = s:AddIndividualLines(l:startLnum, l:endLnum, l:closedFolds)

	let l:lines = s:GetLinesFromRanges(l:ranges)
	let l:reorderedLines = s:ReorderLines(l:lines, a:arguments)
	call ingo#lines#Replace(l:startLnum, l:endLnum, l:reorderedLines)
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction
function! AdvancedSorters#Reorder#Folded( startLnum, endLnum, arguments ) abort
    try
	let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]
	let l:closedFolds = ingo#folds#GetClosedFolds(l:startLnum, l:endLnum)
	let l:other = ingo#range#invert#Invert(l:startLnum, l:endLnum, l:closedFolds)

	let l:reorderedLines = s:ReorderLines(s:GetLinesFromRanges(copy(l:closedFolds)), a:arguments)
	let l:lines = s:Weave(l:closedFolds, l:reorderedLines, l:other)
	call ingo#lines#Replace(l:startLnum, l:endLnum, l:lines)
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    endtry
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
