" Basic Key Mappings



" Set leader key
let mapleader=' '
nnoremap <Space> <Nop>



" Better indenting
vnoremap < <gv
vnoremap > >gv



" ESC is too far away
" inoremap jk <Esc>
" inoremap kj <Esc>



" General {{{
" Save file
nnoremap <silent> <Leader>w :write<CR>
" Save and close
nnoremap <silent> <Leader><S-w> :x<CR>
" Easy align in visual mode
xmap ga <Plug>(EasyAlign)
" Easy align in normal mode
nmap ga <Plug>(EasyAlign)
" Open custom digest for folds
nnoremap <silent> <Leader>= :call CustomFoldDigest()<CR>
" }}}




" Switching {{{
" Next buffer
nnoremap <silent> <Tab> :bnext<CR>
" Previous buffer
nnoremap <silent> <S-Tab> :bprevious<CR>
" Alternate file navigation
nnoremap <silent> <Leader>a :A<CR>
" Alternate file navigation vertical split
nnoremap <silent> <Leader><S-a> :AV<CR>
" }}}



" View Management {{{
" Create vsplit
nnoremap <silent> <leader>\| :call Vsplit()<CR>
" Create hsplit
nnoremap <silent> <Leader>- :call Split()<CR>
" Only window
nnoremap <silent> <Leader>o :only<CR>
" Close the current buffer
nnoremap <silent> <Leader>c :close<CR>
" Close the current buffer
nnoremap <silent> <Leader><S-c> :%close<CR>
" Delete the current buffer
nnoremap <silent> <Leader>x :bdelete<CR>
" Delete the current buffer
nnoremap <silent> <Leader><S-x> :bdelete!<CR>
" Force close all buffers
nnoremap <silent> <Leader>z :%bdelete<CR>
" Close all buffers
nnoremap <silent> <Leader><S-z> :%bdelete!<CR>
" Remap arrows to resize
"nnoremap <silent> <Up>    :call animate#window_delta_height(15)<CR>
"nnoremap <silent> <Down>  :call animate#window_delta_height(-15)<CR>
"nnoremap <silent> <Left>  :call animate#window_delta_width(15)<CR>
"nnoremap <silent> <Right> :call animate#window_delta_width(-15)<CR>
nnoremap <silent> <Up>    :resize -2<CR>
nnoremap <silent> <Down>  :resize +3<CR>
nnoremap <silent> <Left>  :vertical resize -3<CR>
nnoremap <silent> <Right> :vertical resize +3<CR>
" Toggle clean
nnoremap <silent> <F1> :Clean<CR>
" }}}



" Search {{{
" Open fuzzy files with leader \
nnoremap <silent> <Leader>º :Files<CR>
" nnoremap <silent> <Leader>\ :Telescope find_files<CR>
" Open fuzzy lines with leader l
nnoremap <silent> <Leader>l :Lines<CR>
" Open fuzzy buffers with leader b
nnoremap <silent> <Leader>b :Buffers<CR>
" Open ripgrep
nnoremap <silent> <Leader>f :Rg<CR>
" Open global ripgrep
nnoremap <silent> <Leader><S-f> :Rgg<CR>
" Open ripgrep agriculture
nmap <Leader>/ <Plug>RgRawSearch
" Open ripgrep agriculture for visual selection
vmap <Leader>/ <Plug>RgRawVisualSelection
" Remap ** to * now that we are using * for other bindings
nnoremap ** *
" Open ripgrep agriculture for cursor word
nmap */ <Plug>RgRawWordUnderCursor
" Open ripgrep for cursor word
nnoremap <silent> *f :Rg <C-R><C-W><CR>
" Open global ripgrep for cursor word
nnoremap <silent> *<S-f> :Rgg <C-R><C-W><CR>
" }}}





" I hate escape more than anything else

" Easy CAPS
" inoremap <c-u> <ESC>viwUi
" nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" Move selected line / block of text in visual mode
" shift + k to move up
" shift + j to move down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Alternate way to save
nnoremap <silent> <C-s> :w<CR>
" Alternate way to quit
nnoremap <silent> <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <silent> <C-c> <Esc>
" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"



" Better window navigation
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l



" Terminal window navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
tnoremap <Esc> <C-\><C-n>



" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
