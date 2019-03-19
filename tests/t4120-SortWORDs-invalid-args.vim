" Test passing invalid sort arguments.

edit words.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Throws('E475: Invalid argument: doesnotexist', '2SortWORDs doesnotexist', 'Error when passing invalid sort arguments')

call vimtest#SaveOut()
call vimtest#Quit()
