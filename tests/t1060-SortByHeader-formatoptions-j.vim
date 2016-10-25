" Test sorting by start of functions with j in formatoptions.

insert
function BName:
# simple
# note
let g:setting = 1
function AName:
let g:string = "Hello  World"
.

setlocal formatoptions+=j comments=b:#
SortRangesByHeader /^function/

call vimtest#SaveOut()
call vimtest#Quit()
