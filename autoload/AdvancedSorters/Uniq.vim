" AdvancedSorters/Uniq.vim: Keep unique lines.
"
" DEPENDENCIES:
"   - ingo/actions.vim autoload script
"   - ingo/cmdargs/pattern.vim autoload script
"   - ingo/collections.vim autoload script
"   - ingo/lines.vim autoload script
"   - ingo/range.vim autoload script
"
" Copyright: (C) 2015 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.20.001	03-Feb-2015	file creation

function! s:Parse( arguments )
    let l:uniqFlagsExpr = '[ir[:space:]]'
    let [l:flagsBeforePattern, l:restArguments] = matchlist(a:arguments, '^\(' . l:uniqFlagsExpr . '*\)\(.*\)$')[1:2]
    let [l:pattern, l:flagsAfterPattern] = ingo#cmdargs#pattern#ParseUnescaped(l:restArguments, '\(' . l:uniqFlagsExpr . '*\)')
    return [l:flagsBeforePattern . l:flagsAfterPattern, l:pattern]
endfunction
function! s:MakeUnique( lines, modificationExpr )
    if a:modificationExpr ==# 'v:val'
	return ingo#collections#UniqueStable(a:lines)
    endif

    let l:itemDict = {}
    let l:result = []
    let l:nonMatching = []
    for l:line in a:lines
	let l:key = (l:line ==# '' ? "\<Nul>" : ingo#actions#EvaluateWithVal(a:modificationExpr, l:line))
	if empty(l:key)
	    call add(l:result, l:line)
	elseif ! has_key(l:itemDict, l:key)
	    let l:itemDict[l:key] = 1
	    call add(l:result, l:line)
	endif
    endfor
    return l:result
endfunction
function! AdvancedSorters#Uniq#Uniq( startLnum, endLnum, arguments )
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    let [l:flags, l:pattern] = ['', '']
    if ! empty(a:arguments)
	let [l:flags, l:pattern] = s:Parse(a:arguments)
	if l:pattern ==# a:arguments
	    " The parsing should have removed the /.../ delimiters; the argument
	    " either has none, or the argument syntax is wrong.
	    call ingo#err#Set('Invalid argument: ' . a:arguments)
	    return 0
	endif
    endif

    let l:modificationExpr = 'v:val'
    if ! empty(l:pattern)
	if l:flags =~# 'r'
	    let l:modificationExpr = printf("matchstr(v:val, %s)", string(l:pattern))
	else
	    let l:modificationExpr = printf("v:val =~# %s ? substitute(v:val, %s, '', 'g') : ''", string(l:pattern), string(l:pattern))
	endif
    endif
    if l:flags =~# 'i'
	let l:modificationExpr = 'tolower(' . l:modificationExpr . ')'
    endif

    let l:lines = s:MakeUnique(getline(l:startLnum, l:endLnum), l:modificationExpr)
    call ingo#lines#Replace(l:startLnum, l:endLnum, l:lines)
    return 1
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
