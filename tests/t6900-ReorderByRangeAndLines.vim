" Test reordering by range and surrounding lines.

edit functions.txt
ReorderByRangeAndLines /^function/,/^endfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
