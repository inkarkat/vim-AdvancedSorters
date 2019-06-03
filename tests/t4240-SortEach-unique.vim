" Test unique sorting by elements.

edit elements.txt

15,17SortEach /^\s\+\|,\_s*// u
8,11SortEach /,\s*\|,\n/ \/ / u
1,2SortEach /[-_]/!/ u

call vimtest#SaveOut()
call vimtest#Quit()
