" Test reordering by range, within a range.

edit functions.txt
3,26ReorderOnlyByRange /^function/,/^endfunction$/ reverse(v:val)

call vimtest#SaveOut()
call vimtest#Quit()
