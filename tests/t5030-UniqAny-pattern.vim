" Test keeping unique lines ignoring pattern.

edit uniq.txt
Uniq /type: .*: /

call vimtest#SaveOut()
call vimtest#Quit()
