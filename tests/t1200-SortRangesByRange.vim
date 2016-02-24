" Test sorting by range.

edit functions.txt
SortRangesByRange /^function/,/^endfunction$/

call vimtest#SaveOut()
call vimtest#Quit()
