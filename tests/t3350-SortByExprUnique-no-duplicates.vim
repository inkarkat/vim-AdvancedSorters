" Test sorting by a fixed order expression that doesn't yield duplicates.
" Tests that the result is the same as with :SortByExpr.

set encoding=utf-8
edit ++enc=utf-8 lengths.txt

call vimtest#StartTap()
call vimtap#Plan(2)
let g:ordering = [6, 7, 8, 4, 9, 5, 10, 13, 11, 14, 12, 3, 1, 2, 15, 16, 18, 19, 17, 99]
call vimtap#Is(line('$') + 1, len(g:ordering), 'expression is initialized with one value for each line, and sentinel')

SortByExprUnique remove(g:ordering, 0)

call vimtap#Is(g:ordering, [99], 'expression has been evaluated once for each line')

call vimtest#SaveOut()
call vimtest#Quit()
