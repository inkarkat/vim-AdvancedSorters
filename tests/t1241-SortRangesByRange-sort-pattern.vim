" Test sorting by range by actual function name with different delimiter.

edit functions.txt
SortRangesByRange /^function/,/^endfunction$/ @^function! \%(s:\|\%(\w\+#\)*\)@

call vimtest#SaveOut()
call vimtest#Quit()
