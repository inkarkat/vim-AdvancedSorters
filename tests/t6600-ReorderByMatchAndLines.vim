" Test reordering by matched functions and surrounding lines.

edit functions.txt
ReorderByMatchAndLines /^function\_.\{-}\nendfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
