" Test reordering by range and surroundings, within a range.

edit functions.txt
3,26ReorderByRangeAndNonMatches /^function/,/^endfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
