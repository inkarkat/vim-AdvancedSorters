" Test sorting by actual function name.

edit functions.txt
SortRangesByHeader /^function//^function! \%(s:\|\%(\w\+#\)*\)/

call vimtest#SaveOut()
call vimtest#Quit()
