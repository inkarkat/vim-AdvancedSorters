" Test sorting by actual function name.

edit functions.txt
SortRangesByHeader /^function/r/^function! \%(s:\u\l\+\|\w\+#\)/i

call vimtest#SaveOut()
call vimtest#Quit()
