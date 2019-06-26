" Test case-insensitive reverse sorting of visible lines.

edit functions.txt
g/^function/,/^endfunction/fold
SortVisible! i

call vimtest#SaveOut()
call vimtest#Quit()
