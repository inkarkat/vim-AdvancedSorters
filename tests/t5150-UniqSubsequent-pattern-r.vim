" Test keeping subsequent lines where only the matching pattern is unique.

edit uniq.txt
UniqSubsequent /[[:xdigit:]-]\{10,}/r

call vimtest#SaveOut()
call vimtest#Quit()
