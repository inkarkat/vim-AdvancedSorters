" Test reordering by range and surroundings.

edit functions.txt
ReorderByRangeAndNonMatches /^function/,/^endfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
