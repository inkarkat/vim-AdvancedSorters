" Test reordering of a single closed fold.

edit functions.txt
%fold

call vimtest#StartTap()
call vimtap#Plan(1)

call vimtap#err#ErrorsLike('Just a single range; nothing to reorder', 'ReorderVisible reverse(v:val)', 'Error with just a single closed fold')

call vimtest#SaveOut()
call vimtest#Quit()
