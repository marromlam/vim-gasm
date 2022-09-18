local null_ls_status_ok, nls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics

local nls_utils = require "null-ls.utils"
local b = nls.builtins

local with_diagnostics_code = function(builtin)
    return builtin.with {
        diagnostics_format = "#{m} [#{c}]",
    }
end

local with_root_file = function(builtin, file)
    return builtin.with {
        condition = function(utils)
            return utils.root_has_file(file)
        end,
    }
end


local with_root_file_dos = function(files)
    return function(utils)
        --[[ print(utils.root_has_file(files)) ]]
        return utils.root_has_file(files)
    end
end

local sources = {
    b.formatting.fixjson,
    -- b.formatting.black.with { extra_args = { "--fast" } },
    -- b.formatting.black.with { extra_args = { "--fast" } },
    --
    -- c/c++
    b.formatting.clang_format,
    b.formatting.clang_format.with({
        condition = with_root_file_dos({ ".clang-format" }),
    }),

    -- python
    -- b.formatting.isort.with({
    --   condition = with_root_file_dos({"pyproject.toml"}),
    -- }),
    b.formatting.autopep8.with({
        condition = with_root_file_dos({ "pyproject.toml" }),
    }),
    -- b.formatting.black.with({
    --   condition = with_root_file_dos({"pyproject.toml"}),
    -- }),
    -- b.diagnostics.flake8.with({
    --   condition = with_root_file_dos({"pyproject.toml"}),
    -- }),

    -- lua
    -- b.formatting.stylua.with({
    --   condition = with_root_file_dos({".stylua.toml"}),
    -- }),

    -- diagnostics
    b.diagnostics.write_good,
    b.diagnostics.markdownlint,
    b.diagnostics.eslint_d,
    -- b.diagnostics.flake8.with{ condition = with_root_file_dos("pyproject.toml") },
    b.diagnostics.tsc,
    -- with_root_file(b.diagnostics.selene, "selene.toml"),
    with_root_file(b.diagnostics.flake8, "pyproject.toml"),

    -- shell
    b.formatting.shfmt,
    with_diagnostics_code(b.diagnostics.shellcheck),

    -- code actions
    b.code_actions.gitsigns,
    b.code_actions.gitrebase,

    -- hover
    b.hover.dictionary,
}

-- 	formatting.prettier.with({
--      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
--    }),
--
-- 	formatting.black.with({
--      extra_args = { "--fast" }
--    }),
--
-- 	formatting.stylua,
-- },
-- }}}

local opts = {
    on_attach = require("luavim.lsp.handlers").on_attach,
    capabilities = require("luavim.lsp.handlers").capabilities,
}
nls.setup {
    debug = true,
    sources = sources,
    debounce = 150,
    save_after_format = false,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern ".git",
}

-- vim:foldmethod=marker
