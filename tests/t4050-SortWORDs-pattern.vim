" Test sorting with skipped pattern.

edit words.txt

8,$SortWORDs /s:\|.\+#/

call vimtest#SaveOut()
call vimtest#Quit()
