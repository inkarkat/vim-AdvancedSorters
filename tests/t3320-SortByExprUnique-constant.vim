" Test unique sorting by a constant expression.

set encoding=utf-8
edit ++enc=utf-8 lengths.txt

SortByExprUnique 1

call vimtest#SaveOut()
call vimtest#Quit()
