" Test keeping unique subsequent lines ignoring pattern.

edit uniq.txt
UniqSubsequent /type: .*: /

call vimtest#SaveOut()
call vimtest#Quit()
