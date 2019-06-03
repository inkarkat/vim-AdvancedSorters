" Test sorting not a single word.

edit words.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Errors('No WORDs to sort', '8SortWORDs', 'error when on whitespace-only line')

call vimtest#SaveOut()
call vimtest#Quit()
