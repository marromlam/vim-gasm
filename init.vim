"
" Marcos Romero Lamas
"
"    (Neo)Vim configuration file.
"

" Basics {{{
" Load all plugins
source $HOME/.config/nvim/vim-plug/plugins.vim
" General settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/functions.vim
source $HOME/.config/nvim/general/theme.vim
" General key mappings
source $HOME/.config/nvim/keys/mappings.vim
" }}}

" Source config files {{{
" FZF and search
source $HOME/.config/nvim/plug-config/fzf.vim

source $HOME/.config/nvim/plug-config/folding.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
"source $HOME/.config/nvim/plug-config/rnvimr.vim
"source $HOME/.config/nvim/plug-config/ranger.vim
source $HOME/.config/nvim/plug-config/better-whitespace.vim

" Apearance 
source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/animate.vim
source $HOME/.config/nvim/plug-config/neoterm.vim

" Some utils
source $HOME/.config/nvim/plug-config/pomodoro.vim
source $HOME/.config/nvim/plug-config/calendar.vim
source $HOME/.config/nvim/plug-config/camelcase.vim

"source $HOME/.config/nvim/plug-config/codi.vim
"source $HOME/.config/nvim/plug-config/vim-wiki.vim
"luafile $HOME/.config/nvim/lua/nvcodeline.lua
"luafile $HOME/.config/nvim/lua/treesitter.lua

" Cmake
source $HOME/.config/nvim/plug-config/vim-cmake.vim

" CoC
source $HOME/.config/nvim/plug-config/coc/coc.vim
source $HOME/.config/nvim/plug-config/coc/coc-extensions.vim

" Git
source $HOME/.config/nvim/plug-config/gitgutter.vim
source $HOME/.config/nvim/plug-config/fugitive.vim
source $HOME/.config/nvim/plug-config/gitmerge.vim

" Startify
source $HOME/.config/nvim/plug-config/start-screen.vim

" juKitty
source $HOME/.config/nvim/plug-config/slime.vim
source $HOME/.config/nvim/plug-config/ipython-cell.vim

" Goyo
source $HOME/.config/nvim/plug-config/goyo.vim
source $HOME/.config/nvim/plug-config/pencil.vim

" LaTeX
source $HOME/.config/nvim/plug-config/vimtex.vim

" }}}

" This should be deleted or moved elsewhere {{{
" set rtp+=/home3/marcos.romero/.masterbrew/Cellar/vim/
" set rtp+=/home3/marcos.romero/.masterbrew/Cellar/vim/runtime/
" set rtp+=/home3/marcos.romero/.masterbrew/Cellar/vim/8.2.2475/share/vim/vim82/

"let $VIMRUNTIME="/home3/marcos.romero/.masterbrew/share/vim/vim82"
"let g:python3_host_prog = expand("/home3/marcos.romero/.masterbrew/bin/python3.9")
"let $VIMRUNTIME="/home3/marcos.romero/.masterbrew/Cellar/vim/8.2.2475/share/vim/vim82/"

" Table Mode
" let g:table_mode_corner = '|'
" Loupe
" let g:LoupeClearHighlightMap = 0

" let's see about this
" vim:fdm=marker
" vim: set fdm=marker: " Treat comments as folds
" }}}

" Non-GUI Tools {{{
if ! has('gui_running')
  " Open project
  nnoremap <silent> <Leader>] :call openterm#vertical('tmuxinator-fzf-start.sh', 0.2)<CR>
  " Switch session
  nnoremap <silent> <Leader>[ :call openterm#vertical('tmux-fzf-switch.sh', 0.2)<CR>
  " Kill session
  nnoremap <silent> <Leader>} :call openterm#vertical('tmux-fzf-kill.sh', 0.2)<CR>
  " Toggle pomodoro
  nnoremap <silent> <Leader>p :call TogglePomodoro()<CR>
endif

" Cycle line number modes
" nnoremap <silent> <Leader>r :call CycleLineNumbering()<CR>
" Toggle virtualedit
nnoremap <silent> <Leader>v :call ToggleVirtualEdit()<CR>
" Open lazygit
nnoremap <silent> <Leader>' :call openterm#horizontal('lazygit', 0.8)<CR>
" Open lazydocker
nnoremap <silent> <Leader>; :call openterm#horizontal('lazydocker', 0.8)<CR>
" Open scratch pad
nnoremap <silent> <Leader>sc :call openterm#horizontal('bash', 0.2)<CR>
" Calls the custom start function that requests path map to be defined if not already run
nnoremap <silent> <F5> :call StartVdebug()<CR>
" }}}

" Last fix and patches {{{
" Some plugin sets this to 2, or at least thats what it seems to be
set cmdheight=1
" Some plugin overrides this setting too
highlight Comment cterm=italic gui=italic
" }}}
