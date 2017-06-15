" Test keeping unique lines ignoring pattern.

edit uniq.txt
UniqAny /type: .*: /

call vimtest#SaveOut()
call vimtest#Quit()
