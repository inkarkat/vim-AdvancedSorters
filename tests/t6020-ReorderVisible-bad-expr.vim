" Test reordering visible lines with bad expressions.

edit functions.txt
global/^function/,/^endfunction/fold

call vimtest#StartTap()
call vimtap#Plan(2)

call vimtap#err#ErrorsLike('^E471:', 'ReorderVisible', 'Error when no expression passed')
call vimtap#err#ErrorsLike('^E15:', 'ReorderVisible 42 +', 'Error with invalid expression')

call vimtest#Quit()
