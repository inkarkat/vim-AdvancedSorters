" Test reordering unfolded lines, keeping folded in between.

edit functions.txt
global/^function/,/^endfunction/fold
ReorderUnfolded reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
