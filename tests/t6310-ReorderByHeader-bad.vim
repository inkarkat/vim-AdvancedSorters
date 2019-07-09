" Test bad arguments to ReorderByHeader.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(2)

call vimtap#err#Errors('Must pass both /{expr}/ and {reorder-expr}', 'ReorderByHeader /^function/', 'Error when /{expr}/ is omitted')
call vimtap#err#Errors('Must pass both /{expr}/ and {reorder-expr}', 'ReorderByHeader reverse(v:val)', 'Error when {reorder-expr} is omitted')

call vimtest#SaveOut()
call vimtest#Quit()
