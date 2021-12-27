---mappings name
---mappings info

core.noremap({"n"}, "<Up>"   , ":resize -2<CR>")
core.noremap({"n"}, "<Down>" , ":resize +2<CR>")
core.noremap({"n"}, "<Left>" , ":vertical resize -2<CR>")
core.noremap({"n"}, "<Right>", ":vertical resize +2<CR>")
core.noremap({"n"}, "<C-q>", ":call ToggleQFList()<CR>")

-- vim:fdm=marker
