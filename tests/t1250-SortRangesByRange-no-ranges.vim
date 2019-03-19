" Test sorting by nonexisting ranges.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Throws('No ranges found', 'SortRangesByRange /^function/,/^doesnotexist$/', 'Error when there are no ranges')

call vimtest#SaveOut()
call vimtest#Quit()
