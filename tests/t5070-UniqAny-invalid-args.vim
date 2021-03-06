" Test passing invalid sort arguments.

edit uniq.txt
call vimtest#StartTap()
call vimtap#Plan(4)

call vimtap#err#Errors('Invalid argument: doesnotexist', 'UniqAny doesnotexist', 'Error when passing invalid argument doesnotexist')
call vimtap#err#Errors('Invalid argument: y z', 'UniqAny y z', 'Error when passing invalid argument y z')
call vimtap#err#Errors('Invalid argument: /foo/y z', 'UniqAny /foo/y z', 'Error when passing invalid argument /foo/y z')
call vimtap#err#Errors('Invalid argument: /foo', 'UniqAny /foo', 'Error when passing invalid argument /foo')

call vimtest#SaveOut()
call vimtest#Quit()
