" always use tmux
let g:slime_target = 'kitty'

" fix paste issues in ipython
let g:slime_python_ipython = 1

" always send text to the top-right pane in the current tmux tab without asking
"let g:slime_default_config = {
"            \ 'socket_name': get(split($TMUX, ','), 0),
"            \ 'target_pane': '{top-right}' }
"let g:slime_dont_ask_default = 1
