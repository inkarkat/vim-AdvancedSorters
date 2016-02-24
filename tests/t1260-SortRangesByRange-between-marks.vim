" Test sorting by a range defined by two marks.

edit functions.txt
3mark a
13mark b
SortRangesByRange 'a,'b

call vimtest#SaveOut()
call vimtest#Quit()
