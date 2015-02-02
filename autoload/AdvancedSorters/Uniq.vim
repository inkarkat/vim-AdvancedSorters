" AdvancedSorters/Uniq.vim: Keep unique lines.
"
" DEPENDENCIES:
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

function! s:MakeUnique( lines )
    return ingo#collections#UniqueStable(a:lines)
endfunction
function! AdvancedSorters#Uniq#Uniq( startLnum, endLnum, arguments )
    let [l:startLnum, l:endLnum] = [ingo#range#NetStart(a:startLnum), ingo#range#NetEnd(a:endLnum)]

    let l:lines = s:MakeUnique(getline(l:startLnum, l:endLnum))
    call ingo#lines#Replace(l:startLnum, l:endLnum, l:lines)
    return 1
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
