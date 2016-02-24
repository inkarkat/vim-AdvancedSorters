" Test sorting by start of functions within a range.

edit functions.txt
3,26SortRangesByHeader /^function/

call vimtest#SaveOut()
call vimtest#Quit()
