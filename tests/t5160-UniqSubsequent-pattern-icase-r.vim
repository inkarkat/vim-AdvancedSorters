" Test keeping subsequent lines where only the matching pattern is ignoring-case unique.
" Tests that flags can be specified both before and after the pattern.

edit uniq.txt
UniqSubsequent i/[[:xdigit:]-]\{10,}/r

call vimtest#SaveOut()
call vimtest#Quit()
