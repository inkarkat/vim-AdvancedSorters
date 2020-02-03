" Test bad arguments to ReorderByHeader.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(3)

call vimtap#err#Errors('Must pass both /{expr}/ and {reorder-expr}', 'ReorderByHeader /^function/', 'Error when /{expr}/ is omitted')
call vimtap#err#Errors('Must pass both /{expr}/ and {reorder-expr}', 'ReorderByHeader reverse(v:val)', 'Error when {reorder-expr} is omitted')
call vimtap#err#ErrorsLike('^E54:', 'ReorderByHeader /^foo\(bar/ reverse(v:val)', 'Error with invalid pattern')

call vimtest#SaveOut()
call vimtest#Quit()
