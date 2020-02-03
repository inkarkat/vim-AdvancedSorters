" Test reordering by matched functions and surrounding lines, within a range.

edit functions.txt
3,26ReorderByMatchAndLines /^function\_.\{-}\nendfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
