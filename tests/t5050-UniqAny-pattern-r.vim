" Test keeping lines where only the matching pattern is unique.

edit uniq.txt
UniqAny /[[:xdigit:]-]\{10,}/r

call vimtest#SaveOut()
call vimtest#Quit()
