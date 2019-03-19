" Test sorting by nonexisting matches.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Throws('No matches found', 'SortRangesByMatch /^function\_.\{-}\ndoesnotexist$/', 'Error when there are no matches')

call vimtest#SaveOut()
call vimtest#Quit()
