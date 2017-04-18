" Test sorting all individually folded lines.

edit functions.txt
g/^/fold
SortUnfolded

call vimtest#SaveOut()
call vimtest#Quit()
