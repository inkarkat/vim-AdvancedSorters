" Test sorting by range within a range.

edit functions.txt
3,26SortRangesByRange /^function/,/^endfunction$/

call vimtest#SaveOut()
call vimtest#Quit()
