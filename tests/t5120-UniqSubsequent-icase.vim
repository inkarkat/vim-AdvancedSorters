" Test keeping unique subsequent lines ignoring case.

edit uniq.txt
UniqSubsequent i

call vimtest#SaveOut()
call vimtest#Quit()
