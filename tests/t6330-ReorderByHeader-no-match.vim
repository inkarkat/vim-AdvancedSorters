" Test reordering by something that does not match at all.

edit functions.txt
call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#Errors('Just a single range; nothing to reorder', 'ReorderByHeader /^doesNotMatch/ reverse(v:val)', 'Error when /{expr}/ does not match at all')

call vimtest#SaveOut()
call vimtest#Quit()
