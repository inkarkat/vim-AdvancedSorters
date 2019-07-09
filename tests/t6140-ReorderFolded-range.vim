" Test reordering folded lines, keeping unfolded in between, within a range.

edit functions.txt
global/^function/,/^endfunction/fold
3,26ReorderFolded reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
