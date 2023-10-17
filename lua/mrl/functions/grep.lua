vim.cmd([[
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
]])

local function external_grep(word, no_ignore)
    local word0 = (word or vim.fn.input("RG  "))
    if no_ignore then
        vim.cmd((("silent grep " .. word0) .. " --no-ignore"))
    else
        vim.cmd(("silent grep " .. word0))
    end
    return vim.cmd("copen")
end

local function grep_snakemake(filename)
    -- these are the string we will search for with ripgrep
    local _tokens = "(at boundary|WARN|ERROR)"
    -- regexp for filenames
    local _filename = (filename or vim.fn.input("RG <- FD (*)  "))
    -- build the find and ripgrep commands (mind the '')
    local _fd_cmd = 'find . -iname "' .. _filename .. '" -print0'
    local _rg_cmd = 'rg --vimgrep --no-ignore "' .. _tokens .. '"'
    -- pipe find results to rg to search for tokens on them
    local _full_cmd = _fd_cmd .. " | xargs -0 " .. _rg_cmd
    -- vim.cmd("silent cexpr system('" .. _full_cmd .. "')")
    vim.cmd(("silent cexpr system('" .. _full_cmd .. "')"))
    -- print("silent find . -iname '" .. word0 .. "' -print0")
    return vim.cmd("copen")
end

core.map({ "n" }, "<leader>sr", external_grep, "Ripgrep to QuickFix")
core.map({ "n" }, "<leader>ss", grep_snakemake, "Ripgrep to QuickFix")

-- vim: fdm=marker
