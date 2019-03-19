" Test sorting not a single word.

edit words.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Throws('No WORDs to sort', '8SortWORDs', 'Error when no WORDs to sort')

call vimtest#SaveOut()
call vimtest#Quit()
