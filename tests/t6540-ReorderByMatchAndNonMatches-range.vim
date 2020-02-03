" Test reordering by matched functions and surroundings, within a range.

edit functions.txt
3,26ReorderByMatchAndNonMatches /^function\_.\{-}\nendfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
