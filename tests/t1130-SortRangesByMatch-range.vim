" Test sorting by matched pattern within a range.

edit functions.txt
3,26SortRangesByMatch /^function\_.\{-}\nendfunction$/

call vimtest#SaveOut()
call vimtest#Quit()
