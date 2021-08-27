vim.g.latex_view_general_viewer = "zathura"
vim.g.vimtex_view_method = "zathura"


vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_mode = 2

-- One of the neosnippet plugins will conceal symbols in LaTeX which is
-- confusing
vim.g.tex_conceal = ""

-- Can hide specifc warning messages from the quickfix window
-- Quickfix with Neovim is broken or something
-- https://github.com/lervag/vimtex/issues/773
-- vim.g.vimtex_quickfix_latexlog = { 'default' : 1, 'fix_paths' : 0, 'general' : 1, 'references' : 1, 'overfull' : 1, 'underfull' : 1, 'font' : 1, 'packages' : { 'default' : 1, 'natbib' : 1, 'biblatex' : 1, 'babel' : 1, 'hyperref' : 1, 'scrreprt' : 1, 'fixltx2e' : 1, 'titlesec' : 1, }, }
vim.g.vimtex_compiler_latexmk = { build_dir = "build" }
