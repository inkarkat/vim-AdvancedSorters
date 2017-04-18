" Test sorting all individually folded lines.

edit functions.txt

" One-line folds are only shown when the text exceeds the window width. To avoid
" depending on the terminal size, obtain a fixed window width via a vertical
" split.
20vsplit

g/^/fold
SortUnfolded

call vimtest#SaveOut()
call vimtest#Quit()
