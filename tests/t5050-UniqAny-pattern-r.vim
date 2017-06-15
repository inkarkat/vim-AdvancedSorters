" Test keeping lines where only the matching pattern is unique.

edit uniq.txt
Uniq /[[:xdigit:]-]\{10,}/r

call vimtest#SaveOut()
call vimtest#Quit()
