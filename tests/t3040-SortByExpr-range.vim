" Test sorting a range by a expression that uses v:val.

set encoding=utf-8
edit ++enc=utf-8 lengths.txt

3,8SortByExpr len(substitute(v:val, '[^o]', '', 'g'))

call vimtest#SaveOut()
call vimtest#Quit()
