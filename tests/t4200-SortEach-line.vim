" Test sorting by elements.

edit elements.txt

13SortEach /,\s\+/ /
5SortEach /, /, /
1SortEach /_/_/

call vimtest#SaveOut()
call vimtest#Quit()
