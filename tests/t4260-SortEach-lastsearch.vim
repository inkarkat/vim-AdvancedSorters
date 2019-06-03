" Test sorting by elements delimited by the last search pattern.

edit elements.txt

" Prime the command with an unrelated pattern.
8SortEach /: /

let @/ = '-\|,\s*'
13,17SortEach ///
5SortEach // # /
1SortEach

call vimtest#SaveOut()
call vimtest#Quit()
