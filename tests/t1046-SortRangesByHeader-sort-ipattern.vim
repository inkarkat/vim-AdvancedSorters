" Test sorting by actual function name.

edit functions.txt
SortRangesByHeader /^function//^function! \%(s:\u\l\+\|\w\+#\)/ri

call vimtest#SaveOut()
call vimtest#Quit()
