
" Fold config

set foldtext=clean_fold#fold_text_minimal() | " Clean folds

" Open custom digest for folds
nnoremap <silent> <Leader>= :call CustomFoldDigest()<CR>

" Fold Digest {{{
let folddigest_options = "nofoldclose,vertical,flexnumwidth"
let folddigest_size = 40
" }}}
