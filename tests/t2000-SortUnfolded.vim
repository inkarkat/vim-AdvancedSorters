" Test sorting visible lines.

edit functions.txt
g/^function/,/^endfunction/fold
SortUnfolded

call vimtest#SaveOut()
call vimtest#Quit()
