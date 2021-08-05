"             _   _   _                 
"    ___  ___| |_| |_(_)_ __   __ _ ___ 
"   / __|/ _ \ __| __| | '_ \ / _` / __|
"   \__ \  __/ |_| |_| | | | | (_| \__ \
"   |___/\___|\__|\__|_|_| |_|\__, |___/
"                             |___/     

" The basics {{{
set iskeyword+=-                      	" treat dash separated words as a word text object"
set formatoptions-=cro                  " Stop newline continution of comments

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set novisualbell                        " Don't display visual bell
set showmatch                           " Show matching braces
set whichwrap+=<,>,[,],h,l
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set mouse=a                             " Enable your mouse

" Splits default configuration
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right

" Always display the status line
set laststatus=2
" Line numbers
set number relativenumber
" Enable highlighting of the current line
set cursorline
" We don't need to see things like -- INSERT -- anymore
set noshowmode 

" Enable undo persistence
set undofile 
set undodir=.undo/,~/.undo/
" }}}

" Tabs and indentation {{{
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set showtabline=2                       " Always show tabs
" }}}

" Others {{{
" this is recommended by CoC
set nobackup
set nowritebackup
" }}}

" hmmm {{{
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms (500 before)

set dictionary=/usr/share/dict/words 
set spelllang=en

" Don't change dirs automatically
set noautochdir
" Your working directory will always be the same as your working directory
" set autochdir                           
" No sound
set noerrorbells

" Copy paste between vim and everything else
set clipboard+=unnamedplus 
" set clipboard=unnamed

" }}}

" Highlight Customizations {{{
" Make comments in italics (,bold)
highlight Comment gui=italic,bold
let g:vimtex_quickfix_latexlog = {'default' : 0}
"}}}

" Python paths {{{
let g:python3_host_prog = expand("$HOMEBREW_PREFIX/bin/python3.9")
let g:pydocstring_doq_path = expand("$HOMEBREW_PREFIX/bin/doq")
autocmd FileType python setlocal tabstop=2 shiftwidth=2 smarttab expandtab
" }}}

" Indent Guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 1
let g:indent_guides_exclude_filetypes = ['help',
                                        \'fzf',
                                        \'openterm',
                                        \'coc-explorer',
                                        \'neoterm',
                                        \'startify',
                                        \'calendar']
" }}}

" Ignore files {{{
set wildignore+=*.aux,*.out,*.toc    " LaTeX
set wildignore+=*.orig               " Merge files
set wildignore+=*.sw?                " Vim swap files
set wildignore+=.DS_Store            " OSX files
set wildignore+=.git,.hg             " Version control files
"}}}

" Search {{{
" Incremental search
set incsearch
" Ignore case in search
set ignorecase
" Overrides ignore when capital exists
set smartcase
" Displays incremental replacement in neovim
if has('nvim')
  set inccommand=split
endif
" }}}

" New stuff {{{
" set notimeout nottimeout
" set scrolloff=1
" set sidescroll=1
" set sidescrolloff=1
" set display+=lastline
" set backspace=eol,start,indent
" set nostartofline
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" set mmp=1300
" set foldcolumn=2                        " Folding abilities
" }}}


" some last stuff
" au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" You can't stop me
cmap w!! w !sudo tee %


" These are for linters... {{{
" Python
let g:pymode_lint_checkers = ['mccabe', 'pyflakes', 'pylint', 'pep8', 'pep257']
let g:pymode_lint_ignore = 'E111,W0311'
" }}}

