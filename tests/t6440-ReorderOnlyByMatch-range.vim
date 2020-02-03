" Test reordering by matched functions, within a range.

edit functions.txt
3,26ReorderOnlyByMatch /^function\_.\{-}\nendfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
