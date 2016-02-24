" Test sorting unique areas by start of functions.

edit functions.txt
SortRangesByHeader /^function/u

call vimtest#SaveOut()
call vimtest#Quit()
