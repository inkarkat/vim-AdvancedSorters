" Test bad arguments to ReorderOnlyByRange.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(4)

call vimtap#err#Errors('Must pass both {range} and {reorder-expr}', 'ReorderOnlyByRange /^function/,/^endfunction$/', 'Error when {range} is omitted')
call vimtap#err#Errors('Must pass both {range} and {reorder-expr}', 'ReorderOnlyByRange reverse(v:val)', 'Error when {reorder-expr} is omitted')

call vimtap#err#Errors('Just a single range; nothing to reorder', 'ReorderOnlyByRange /^foo\(bar/,$ reverse(v:val)', 'Error with invalid pattern in range is suppressed but results in a single range')
call vimtap#err#Errors('Just a single range; nothing to reorder', 'ReorderOnlyByRange 1,999 reverse(v:val)', 'Error with out-of-bounds range is suppressed by results in a single range')

call vimtest#SaveOut()
call vimtest#Quit()
