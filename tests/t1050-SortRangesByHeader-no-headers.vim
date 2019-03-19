" Test sorting by start of nonexisting header.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Errors('No headers found', 'SortRangesByHeader /^doesnotexist/', 'Error when there are no headers')

call vimtest#SaveOut()
call vimtest#Quit()
