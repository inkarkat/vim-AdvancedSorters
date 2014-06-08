" AdvancedSorters/Ranges.vim: Sorting of whole ranges as one unit.
"
" DEPENDENCIES:
"   - ingo/err.vim autoload script
"   - ingo/join.vim autoload script
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	08-Jun-2014	file creation from ingocommands.vim

function! s:SortRanges( bang, startLnum, endLnum, sortArgs, rangeName, rangeNum, joinCnt )
    if empty(a:rangeNum)
	call ingo#err#Set(printf('No %s found', a:rangeName))
	return 0
    endif

    let l:reducedEndLnum = a:endLnum - a:joinCnt
    try
	execute printf('%d,%dsort%s %s', a:startLnum, l:reducedEndLnum, a:bang, a:sortArgs)
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    finally
	silent execute printf('%d,%dsubstitute/\%%d0/\r/g', a:startLnum, l:reducedEndLnum)
	call histdel('search', -1)
    endtry
endfunction
function! AdvancedSorters#Ranges#Unfolded( bang, startLnum, endLnum, sortArgs )
    let [l:foldNum, l:joinCnt] = ingo#join#FoldedLines(1, a:startLnum, a:endLnum, "\<C-v>\<C-j>")
    return s:SortRanges(a:bang, a:startLnum, a:endLnum, a:sortArgs, 'folds', l:foldNum, l:joinCnt)
endfunction

function! s:ParseExpressionAndSortArguments( arguments )
    return ingo#cmdargs#pattern#ParseUnescaped(a:arguments, '\s*\([iurnxo[:space:]]*\%(\([[:alnum:]\\"|]\@![\x00-\xFF]\)\(.\{-}\)\%(\%(^\|[^\\]\)\%(\\\\\)*\\\)\@<!\4\)\?\)')
endfunction
function! s:JoinRanges( bang, startLnum, endLnum, arguments, RangeCreator )
    let [l:expr, l:sortArgs] = s:ParseExpressionAndSortArguments(a:arguments)

    let l:ranges = call(a:RangeCreator, [a:startLnum, a:endLnum, l:expr])

    let [l:rangeNum, l:joinCnt] = ingo#join#Ranges(1, a:startLnum, a:endLnum, "\<C-v>\<C-j>", l:ranges)

    return s:SortRanges(a:bang, a:startLnum, a:endLnum, l:sortArgs, 'ranges', l:rangeNum, l:joinCnt)
endfunction
function! s:ByHeader( startLnum, endLnum, expr )
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
function! AdvancedSorters#Ranges#ByHeader( bang, startLnum, endLnum, arguments )
    return s:JoinRanges(a:bang, a:startLnum, a:endLnum, a:arguments, function('s:ByHeader'))
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
