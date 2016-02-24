" Test sorting by matched pattern.

edit functions.txt
SortRangesByMatch /^function\_.\{-}\nendfunction$/

call vimtest#SaveOut()
call vimtest#Quit()
