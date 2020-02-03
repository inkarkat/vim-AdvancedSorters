" Test sorting visible lines within a range.

edit functions.txt
g/^function/,/^endfunction/fold
3,26SortVisible

call vimtest#SaveOut()
call vimtest#Quit()
