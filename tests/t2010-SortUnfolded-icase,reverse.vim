" Test case-insensitive reverse sorting of visible lines.

edit functions.txt
g/^function/,/^endfunction/fold
SortUnfolded! i

call vimtest#SaveOut()
call vimtest#Quit()
