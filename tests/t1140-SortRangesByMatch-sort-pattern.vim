" Test sorting by matched pattern by actual function name.

edit functions.txt
SortRangesByMatch /^function\_.\{-}\nendfunction$//^function! \%(s:\|\%(\w\+#\)*\)/

call vimtest#SaveOut()
call vimtest#Quit()
