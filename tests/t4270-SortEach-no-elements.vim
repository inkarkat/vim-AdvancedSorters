" Test sorting not a single element.

edit elements.txt

call vimtest#StartTap()
call vimtap#Plan(3)

call vimtap#err#ErrorsLike('^E486: ', '1SortEach /@/', 'error when no separators parsed')
call vimtap#err#Errors('No elements to sort', '2SortEach /[^:;]*/', 'error on line that just consists of separators')
call vimtap#err#Errors('No elements to sort', '3SortEach /.*/', 'error on empty line')

call vimtest#Quit()
