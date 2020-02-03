" Test reordering by a single area.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(2)

call vimtap#err#Errors('Just a single range; nothing to reorder', 'ReorderOnlyByRange /^doesNotMatch/ reverse(v:val)', 'Error when {range} does not match at all')
call vimtap#err#Errors('Just a single range; nothing to reorder', 'ReorderOnlyByRange 1,$ reverse(v:val)', 'Error when {range} is the entire buffer')

call vimtest#SaveOut()
call vimtest#Quit()
