" Test bad arguments to ReorderOnlyByRange.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(2)

call vimtap#err#Errors('Must pass both {range} and {reorder-expr}', 'ReorderOnlyByRange /^function/,/^endfunction$/', 'Error when {range} is omitted')
call vimtap#err#Errors('Must pass both {range} and {reorder-expr}', 'ReorderOnlyByRange reverse(v:val)', 'Error when {reorder-expr} is omitted')

call vimtest#SaveOut()
call vimtest#Quit()
