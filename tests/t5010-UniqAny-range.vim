" Test keeping unique lines within a range.

edit uniq.txt
2,10Uniq

call vimtest#StartTap()
call vimtap#Plan(2)
call vimtap#Is(getpos("'["), [0, 2, 1, 0], 'start of change')
call vimtap#Is(getpos("']"), [0, 8, 61, 0], 'end of change')

call vimtest#SaveOut()
call vimtest#Quit()
