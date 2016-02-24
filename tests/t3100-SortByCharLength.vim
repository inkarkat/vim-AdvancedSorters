" Test sorting by number of characters.

set encoding=utf-8
edit ++enc=utf-8 lengths.txt

SortByCharLength

call vimtest#SaveOut()
call vimtest#Quit()
