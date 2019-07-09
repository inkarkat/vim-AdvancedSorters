" AdvancedSorters/Ranges.vim: Sorting of whole ranges as one unit.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2014-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
let s:save_cpo = &cpo
set cpo&vim

function! s:SortRanges( bang, startLnum, endLnum, sortArgs, rangeName, rangeNum, joinCnt )
    if a:rangeNum <= 0
	call ingo#err#Set(printf('No %s found', a:rangeName))
	return 0
    endif

    let l:reducedEndLnum = a:endLnum - a:joinCnt
    let l:lastLnum = line('$')  " When the "u" flag is passed, duplicate lines reduce the number of lines.
    let l:sortOffset = 0        " Account for the reduced end line number when undoing the join.
    try
	execute printf('%d,%dsort%s %s', a:startLnum, l:reducedEndLnum, a:bang, a:sortArgs)
	let l:sortOffset = line('$') - l:lastLnum
	return 1
    catch /^Vim\%((\a\+)\)\=:/
	call ingo#err#SetVimException()
	return 0
    finally
	silent execute printf('%d,%dsubstitute/\%%d0/\r/ge', a:startLnum, l:reducedEndLnum + l:sortOffset)
	call histdel('search', -1)
    endtry
endfunction
function! AdvancedSorters#Ranges#Visible( bang, startLnum, endLnum, sortArgs )
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    let l:save_formatoptions = &l:formatoptions
    setlocal formatoptions=
    try
	let [l:foldNum, l:joinCnt] = ingo#join#FoldedLines(1, l:startLnum, l:endLnum, "\<C-v>\<C-j>")
    finally
	let &l:formatoptions = l:save_formatoptions
    endtry

    return s:SortRanges(a:bang, l:startLnum, l:endLnum, a:sortArgs, 'folds', l:foldNum, l:joinCnt)
endfunction

let s:sortFlagsExpr = '[iurnxo[:space:]]'
function! AdvancedSorters#Ranges#GetSortArgumentsExpr( captureNum, flagsBeforePatternCardinality, ... )
    return '\s*\(' .
    \   s:sortFlagsExpr . a:flagsBeforePatternCardinality .
    \   '\%(\([[:alnum:]\\"|]\@![\x00-\xFF]\)\(.\{-}\)\%(\%(^\|[^\\]\)\%(\\\\\)*\\\)\@<!\' . a:captureNum . '\)\?' .
    \   s:sortFlagsExpr . '*' .
    \'\)'
endfunction
function! s:ParseExpressionAndSortArguments( arguments )
    return ingo#cmdargs#pattern#ParseUnescaped(a:arguments, AdvancedSorters#Ranges#GetSortArgumentsExpr(4, '*'))
endfunction
function! s:JoinRanges( bang, startLnum, endLnum, arguments, ArgumentParser, rangeName, RangeCreator )
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]
    let [l:expr, l:sortArgs] = call(a:ArgumentParser, [a:arguments])

    let l:ranges = call(a:RangeCreator, [l:startLnum, l:endLnum, l:expr])

    let l:save_formatoptions = &l:formatoptions
    setlocal formatoptions=
    try
	let [l:rangeNum, l:joinCnt] = ingo#join#Ranges(1, l:startLnum, l:endLnum, "\<C-v>\<C-j>", l:ranges)
    finally
	let &l:formatoptions = l:save_formatoptions
    endtry

    return s:SortRanges(a:bang, l:startLnum, l:endLnum, l:sortArgs, a:rangeName, l:rangeNum, l:joinCnt)
endfunction



function! AdvancedSorters#Ranges#ByHeader( bang, startLnum, endLnum, arguments )
    return s:JoinRanges(a:bang, a:startLnum, a:endLnum, a:arguments, function('s:ParseExpressionAndSortArguments'), 'headers', function('AdvancedSorters#GetRanges#FromHeader'))
endfunction

function! AdvancedSorters#Ranges#ByMatch( bang, startLnum, endLnum, arguments )
    return s:JoinRanges(a:bang, a:startLnum, a:endLnum, a:arguments, function('s:ParseExpressionAndSortArguments'), 'matches', function('AdvancedSorters#GetRanges#FromMatch'))
endfunction

function! s:ParseRangeAndSortArguments( arguments )
    " Since both the range and the sort arguments can contain a /{pattern}/,
    " parsing is difficult. It's easier when there's a sort flag or whitespace
    " in between, so look for such first.
    let l:parsedRange = ingo#cmdargs#range#Parse(a:arguments, {'isParseFirstRange': 1, 'commandExpr': AdvancedSorters#Ranges#GetSortArgumentsExpr(5, '\+') . '$'})
    if empty(l:parsedRange)
	" Else, take the entire arguments as a range, with only optional sort
	" flags allowed (but no sort pattern). This means that here, there
	" *must* be a space or a sort flag between the /{pat1}/,/{pat2}/ range
	" and the /{pattern}/ sort argument.
	let l:parsedRange = ingo#cmdargs#range#Parse(a:arguments, {'isParseFirstRange': 1, 'commandExpr': '\s*\(' . s:sortFlagsExpr . '*\)$'})
    endif

    if empty(l:parsedRange)
	return ['', '']
    endif
    return l:parsedRange[3:4]
endfunction
function! AdvancedSorters#Ranges#ByRange( bang, startLnum, endLnum, arguments )
    return s:JoinRanges(a:bang, a:startLnum, a:endLnum, a:arguments, function('s:ParseRangeAndSortArguments'), 'ranges', function('AdvancedSorters#GetRanges#FromRange'))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
