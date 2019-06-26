" Test sorting visible lines.

edit functions.txt
g/^function/,/^endfunction/fold
SortVisible

call vimtest#SaveOut()
call vimtest#Quit()
