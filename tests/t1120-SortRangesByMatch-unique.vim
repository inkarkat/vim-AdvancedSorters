" Test unique sorting by matched pattern.

edit functions.txt
SortRangesByMatch /^function\_.\{-}\nendfunction$/u

call vimtest#SaveOut()
call vimtest#Quit()
