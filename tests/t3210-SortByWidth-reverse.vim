" Test reverse sorting by display width.

set encoding=utf-8
edit ++enc=utf-8 lengths.txt

SortByWidth!

call vimtest#SaveOut()
call vimtest#Quit()
