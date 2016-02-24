" Test unique sorting by range.

edit functions.txt
SortRangesByRange /^function/,/^endfunction$/u

call vimtest#SaveOut()
call vimtest#Quit()
