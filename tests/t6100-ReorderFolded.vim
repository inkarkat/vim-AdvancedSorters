" Test reordering folded lines, keeping unfolded in between.

edit functions.txt
global/^function/,/^endfunction/fold
ReorderFolded reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
