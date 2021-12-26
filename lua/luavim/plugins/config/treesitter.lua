local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end


configs.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
     "bash",
     "lua",
     "cpp",
     "python",
     "latex",
     -- "markdown"
  },
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    disable = { "" },  -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
      enable = true,
      enable_autocmd = false,
    }
}
