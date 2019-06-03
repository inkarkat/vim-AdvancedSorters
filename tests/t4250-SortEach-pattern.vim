" Test sorting with sort pattern by elements.

edit elements.txt

15,17SortEach /^\s\+\|,\_s*// ru /\w\+()/
13SortEach /^\s\+\|,\_s*// r /\w\+()/
8,11SortEach /,\s*\|,\n/ / /'\a': /
1,2SortEach /[-_]/_/ /^./

call vimtest#SaveOut()
call vimtest#Quit()
