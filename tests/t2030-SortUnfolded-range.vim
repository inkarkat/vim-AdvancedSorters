" Test sorting visible lines within a range.

edit functions.txt
g/^function/,/^endfunction/fold
3,26SortUnfolded

call vimtest#SaveOut()
call vimtest#Quit()
