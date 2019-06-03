" Test reverse, icase, numeric sorting by elements.

edit elements.txt

15,17SortEach! /^\s\+\|,\_s*/ / i
8,11SortEach! /,\s*\|,\n/, / i
5SortEach /,\s*\|,\n/, / n
1,2SortEach! /[-_]/_/ i

call vimtest#SaveOut()
call vimtest#Quit()
