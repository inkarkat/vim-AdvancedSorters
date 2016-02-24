" Test case-insensitive reverse sorting by range.

edit functions.txt
SortRangesByRange! /^function/,/^endfunction$/i

call vimtest#SaveOut()
call vimtest#Quit()
