" Test sorting all lines, without folding.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Errors('No folds found', 'SortUnfolded', 'Error when there are no folds')

call vimtest#SaveOut()
call vimtest#Quit()
