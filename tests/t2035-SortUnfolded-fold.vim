" Test sorting visible lines within a fold.

edit functions.txt
g/^function/,/^endfunction/fold
3,23SortUnfolded

call vimtest#SaveOut()
call vimtest#Quit()
