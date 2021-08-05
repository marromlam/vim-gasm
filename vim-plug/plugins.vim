" PLUGINS



" Auto-install vim-plug {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Before plugin load configs
let g:polyglot_disabled = ['latex']
" }}}



call plug#begin('~/.config/nvim/autoload/plugged')

" Defaults {{{
" Go to last position when opening files                              [MUST]
Plug 'farmergreg/vim-lastplace'
" Sensible defaults
Plug 'tpope/vim-sensible' 
" Better Comments
Plug 'tpope/vim-commentary'
" Change dates fast
Plug 'tpope/vim-speeddating'
" Convert binary, hex, etc..
"Plug 'glts/vim-radical'
" Repeat stuff
Plug 'tpope/vim-repeat'
" Text Navigation
Plug 'unblevable/quick-scope'
" Useful for React Commenting 
"Plug 'suy/vim-context-commentstring'
" Highlight all matches under cursor
Plug 'RRethy/vim-illuminate'
" Mouse support
Plug 'wincent/terminus'
"}}}


" Navigation {{{
Plug 'tpope/vim-projectionist' | " Navigation of related files
Plug 'tpope/vim-vinegar'
if ($IS_TMUX==1)
  " echo "is tmux = true"
  " Seamlessly navigation between vim and tmux                          [MUST]
  Plug 'christoomey/vim-tmux-navigator'
  let g:tmux_navigator_save_on_switch = 1
  " Vimux - tmux pannels runing files from vim
  "Plug 'benmills/vimux'
else
  " echo "is tmux = false"
  Plug 'knubie/vim-kitty-navigator'
  set title
  let &titlestring='%t - nvim'
endif
" }}}


" Visual {{{
Plug 'blueyed/vim-diminactive'                | " Helps identifying active window
Plug 'camspiers/animate.vim'                  | " Animation plugin
Plug 'nathanaelkane/vim-indent-guides'        | " Provides indentation guides
Plug 'vim-airline/vim-airline'                | " Statusline

" Themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

" Visualize folds
Plug 'arecarn/vim-clean-fold'
Plug 'vim-scripts/folddigest.vim'
Plug 'wincent/loupe'                          | " Search context improvements
"Plug 'majutsushi/tagbar'
" }}}



" Easymotion
" Plug 'easymotionvim-easymotion'
" Surround
Plug 'tpope/vim-surround'
" Have the file system follow you around
Plug 'airblade/vim-rooter'
" auto set indent settings
Plug 'tpope/vim-sleuth'
" Treesitter
"Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'nvim-treesitter/playground'
" Cool Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" Closetags
"Plug 'alvan/vim-closetag'
" Themes
"Plug 'christianchiarulli/nvcode-color-schemes.vim'
" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Status Line
"Plug 'glepnir/galaxyline.nvim'
"Plug 'kevinhwang91/rnvimr'


" Search {{{
" Ripgrep options fro FZF
Plug 'jesseleite/vim-agriculture'
" Main FZF flugin                                                        [MUST]
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Fuzzy finding plugin                                                   [MUST]
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf.vim'
" }}}


" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rhubarb'
"Plug 'junegunn/gv.vim'
"Plug 'rhysd/git-messenger.vim'
" Terminal
Plug 'voldikss/vim-floaterm'
" Start Screen
Plug 'mhinz/vim-startify'
"""" Vista
"""Plug 'liuchengxu/vista.vim'
"""" See what keys do like in emacs
"""Plug 'liuchengxu/vim-which-key'
"""" Zen mode
"""Plug 'junegunn/goyo.vim'
"""Plug 'mattn/emmet-vim'
"""" Interactive code
"""Plug 'metakirby5/codi.vim'
"""" Better tabline
"""Plug 'romgrk/barbar.nvim'
"""" undo time travel
"""Plug 'mbbill/undotree'
"""" Find and replace
"""Plug 'ChristianChiarulli/far.vim'
"""" Auto change html tags
"""Plug 'AndrewRadev/tagalong.vim'
"""" live server
"""Plug 'turbio/bracey.vim'
"""" Smooth scroll
"""Plug 'psliwka/vim-smoothie'
"""" " async tasks
"""Plug 'skywind3000/asynctasks.vim'
"""Plug 'skywind3000/asyncrun.vim'
"""" Swap windows
"""Plug 'wesQ3/vim-windowswap'
"""" Markdown Preview
"""Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
"""" Easily Create Gists
"""Plug 'mattn/vim-gist'
"""Plug 'mattn/webapi-vim'
"""" Colorizer
"""Plug 'norcalli/nvim-colorizer.lua'
"""" Intuitive buffer closing
"""Plug 'moll/vim-bbye'
"""" Debugging
"""Plug 'puremourning/vimspector'
"""Plug 'szw/vim-maximizer'
"""" Neovim in Browser
"""Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(1) } }
" Rainbow brackets
" Plug 'luochen1990/rainbow'
" Async Linting Engine
" TODO make sure to add ale config before plugin
" Plug 'dense-analysis/ale'
" Better Whitespace
" Plug 'ntpeters/vim-better-whitespace'
" Multiple Cursors
" TODO add this back in change from C-n
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'jelera/vim-javascript-syntax'
" Plug Graveyard



" Editor {{{
Plug 'bkad/CamelCaseMotion'          | " Motions for inside camel case
"Plug 'editorconfig/editorconfig-vim' | " Import tabs etc from editorconfig
"Plug 'honza/vim-snippets'            | " A set of common snippets
Plug 'junegunn/vim-easy-align'       | " Helps alignment
Plug 'kkoomen/vim-doge'              | " Docblock generator
Plug 'lervag/vimtex'                 | " Support for vimtex
Plug 'romainl/vim-cool'              | " Awesome search highlighting
Plug 'tomtom/tcomment_vim'           | " Better commenting
" }}}



" Tools {{{
Plug 'dhruvasagar/vim-table-mode'    | " Better handling for tables in markdown
"Plug 'itchyny/calendar.vim'          | " Nice calendar app
Plug 'kassio/neoterm'                | " REPL integration
Plug 'reedes/vim-pencil'             | " Auto hard breaks for text files
Plug 'samoshkin/vim-mergetool'       | " Merge tool for git
Plug 'sedm0784/vim-you-autocorrect'  | " Automatic autocorrect
Plug 'tpope/vim-obsession'           | " Save sessions automatically
Plug 'cdelledonne/vim-cmake'
"Plug 'tpope/vim-unimpaired'          | " Common mappings for many needs
"Plug 'vim-vdebug/vdebug'             | " Debugging, loaded manually
"Plug 'cedarbaum/fugitive-azure-devops.vim'
"Plug 'iamcco/markdown-preview.nvim'
"Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' } 
" }}}



" Debug
" Plug 'mfussenegger/nvim-dap'
" Plug 'nvim-dap-virtual-text'
" Sneak
" Plug 'justinmk/vim-sneak'
" Plug 'nvim-treesitter/nvim-treesitter-refactor'
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'romgrk/nvim-treesitter-context'
" Minimap
" Plug 'wfxr/minimap.vim'
" jsx syntax support
" Typescript syntax
" Plug 'HerringtonDarkholme/yats.vim'
" Multiple Cursors
" Plug 'terryma/vim-multiple-cursors'
" Plug 'kaicataldo/material.vim'
" Plug 'tomasiser/vim-code-dark'
" Plug 'mg979/vim-xtabline'
" Files
" Plug 'tpope/vim-eunuch'
" Vim Wiki
" Plug 'https://github.com/vimwiki/vimwiki.git'
" Better Comments
" Plug 'jbgutierrez/vim-better-comments'
" Echo doc
" Plug 'Shougo/echodoc.vim'
" Plug 'hardcoreplayers/spaceline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Ranger
" Plug 'francoiscabrol/ranger.vim'
" Plug 'rbgrouleff/bclose.vim'
"Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
" Making stuff
" Plug 'neomake/neomake'
" Plug 'mhinz/vim-signify'
" Plug 'preservim/nerdcommenter'
" Plug 'brooth/far.vim'
" Plug 'atishay/far.vim'
" Plug 'romgrk/lib.kom'
" Plug 'brooth/far.vim'
" Debugging

" Syntax {{{
" Lang pack                                                               [MUST]
Plug 'sheerun/vim-polyglot'
" Add snakemake language
Plug 'ibab/vim-snakemake'
Plug 'chrisbra/csv.vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
" Translator                                                            [DNIINI]
" Plug 'voldikss/vim-translator'
" }}}

Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Looks nice, but... not really helpful
" Plug 'metakirby5/codi.vim'
" This works like Hydrogen in Atom, but...
" Plug 'mrossinek/deuterium'

call plug#end()



" Automatically install missing plugins on startup
" autocmd VimEnter *
"   \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"   \|   PlugInstall --sync | q
"   \| endif/


" let g:kitty_navigator_listening_on_address='unix:/tmp/mykitty'



" vim: foldmethod=marker
