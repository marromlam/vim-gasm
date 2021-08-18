-- Fold config

-- vim.g.foldtext=clean_fold#fold_text_minimal() | " Clean folds

-- Open custom digest for folds
-- nnoremap <silent> <Leader>= :call CustomFoldDigest()<CR>

-- Fold Digest {{{

vim.g.folddigest_options = "nofoldclose,vertical,flexnumwidth"
vim.g.folddigest_size = 40

-- }}}
