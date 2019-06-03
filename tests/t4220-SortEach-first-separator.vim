" Test sorting by elements, joining with the first found separator.

edit elements.txt

15,17SortEach /^\s\+\|,\_s*/
8,11SortEach /,\s*\|,\n/
1,2SortEach /[-_]/

call vimtest#SaveOut()
call vimtest#Quit()
