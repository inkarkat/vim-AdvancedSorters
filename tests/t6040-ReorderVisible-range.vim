" Test reordering visible lines within a range.

edit functions.txt
global/^function/,/^endfunction/fold
3,26ReorderVisible reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
