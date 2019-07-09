" Test reordering by start of functions.

edit functions.txt
ReorderByHeader /^function/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
