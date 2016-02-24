" Test sorting by range within a fold.

edit functions.txt
3,26fold
3SortRangesByRange /^function/,/^endfunction$/

call vimtest#SaveOut()
call vimtest#Quit()
