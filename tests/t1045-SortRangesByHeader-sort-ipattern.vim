" Test sorting by actual function name.

edit functions.txt
SortRangesByHeader /^function/ri/^function! \%(s:\u\l\+\|\w\+#\)/

call vimtest#SaveOut()
call vimtest#Quit()
