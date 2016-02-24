" Test sorting by start of functions.

edit functions.txt
SortRangesByHeader /^function/

call vimtest#SaveOut()
call vimtest#Quit()
