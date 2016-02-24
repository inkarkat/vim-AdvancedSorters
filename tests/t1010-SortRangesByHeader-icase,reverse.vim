" Test case-insensitive reverse sorting by start of functions.

edit functions.txt
SortRangesByHeader! /^function/i

call vimtest#SaveOut()
call vimtest#Quit()
