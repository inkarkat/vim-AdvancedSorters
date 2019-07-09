" Test reordering by range.

edit functions.txt
ReorderOnlyByRange /^function/,/^endfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
