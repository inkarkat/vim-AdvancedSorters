" Test sorting visible lines with j in formatoptions.

insert
" BName: {{{1
" note
let g:setting = 1
" AName: {{{1
let g:string = "Hello  World"
.

setlocal foldmethod=marker formatoptions+=j comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
SortVisible

call vimtest#SaveOut()
call vimtest#Quit()
