" Test sorting by range by actual function name with intermediate flag.

edit functions.txt
SortRangesByRange /^function/,/^endfunction$/i/^function! \%(s:\|\%(\w\+#\)*\)/

call vimtest#SaveOut()
call vimtest#Quit()
