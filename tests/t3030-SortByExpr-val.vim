" Test sorting by a expression that uses v:val.

set encoding=utf-8
edit ++enc=utf-8 lengths.txt

SortByExpr len(substitute(v:val, '[^o]', '', 'g'))

call vimtest#SaveOut()
call vimtest#Quit()
