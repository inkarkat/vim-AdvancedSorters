" Test keeping unique subsequent lines ignoring pattern that only matches some lines.
" Tests that the non-matching lines are kept duplicate and in the original
" position.

edit uniq.txt
UniqSubsequent /type: Business Rules id: /

call vimtest#SaveOut()
call vimtest#Quit()
