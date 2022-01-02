local present, configs = pcall(require, "nvim-treesitter.configs")
if not present then
	return
end

configs.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
     "bash",
     "lua",
     "vim",
     "cpp",
     "python",
     "latex",
     -- "markdown"
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,
    disable = { "" },  -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
    use_languagetree = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
      enable = true,
      enable_autocmd = false,
    }
}

-- vim: fdm=marker
