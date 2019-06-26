" Test sorting visible lines by actual function name..

edit functions.txt
g/^function/,/^endfunction/fold
SortVisible /^function! \%(s:\|\%(\w\+#\)*\)/

call vimtest#SaveOut()
call vimtest#Quit()
