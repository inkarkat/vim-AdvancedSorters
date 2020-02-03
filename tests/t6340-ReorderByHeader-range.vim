" Test reordering by start of functions, within a range.

edit functions.txt
3,26ReorderByHeader /^function/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
