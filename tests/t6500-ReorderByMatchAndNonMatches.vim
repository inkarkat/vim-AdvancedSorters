" Test reordering by matched functions and surroundings.

edit functions.txt
ReorderByMatchAndNonMatches /^function\_.\{-}\nendfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
