" Test case-insensitive reverse sorting by matched pattern.

edit functions.txt
SortRangesByMatch! /^function\_.\{-}\nendfunction$/i

call vimtest#SaveOut()
call vimtest#Quit()
