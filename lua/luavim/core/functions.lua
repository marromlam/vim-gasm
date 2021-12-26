
vim.cmd[[
set grepprg=rg\ --vimgrep

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
]]


local function external_grep(word, no_ignore)
  local word0 = (word or vim.fn.input("RG  "))
  if no_ignore then
    vim.cmd((("silent grep " .. word0) .. " --no-ignore"))
  else
    vim.cmd(("silent grep " .. word0))
  end
  return vim.cmd("copen")
end


core.map({'n'}, "<leader>ss", external_grep, "Ripgrep to QuickFix")


-- vim:foldmethod=marker
