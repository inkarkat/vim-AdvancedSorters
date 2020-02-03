" Test reordering visible lines.

edit functions.txt
global/^function/,/^endfunction/fold
ReorderVisible reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
