" Test reordering by matched functions.

edit functions.txt
ReorderOnlyByMatch /^function\_.\{-}\nendfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
