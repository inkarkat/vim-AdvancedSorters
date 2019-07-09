" Test reordering by range and surrounding lines, within a range.

edit functions.txt
3,26ReorderByRangeAndLines /^function/,/^endfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
