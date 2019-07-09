" Test reordering all lines.

edit functions.txt
ReorderVisible reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
