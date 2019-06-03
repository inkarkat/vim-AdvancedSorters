" Test sorting by elements in a range.

edit elements.txt

15,17SortEach /^\s\+\|,\_s*/ /
8,11SortEach /,\s*\|,\n/, /
1,2SortEach /[-_]/_/

call vimtest#SaveOut()
call vimtest#Quit()
