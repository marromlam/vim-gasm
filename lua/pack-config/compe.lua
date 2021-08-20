local present, compe = pcall(require, "compe")
if not present then
   return
end

compe.setup {
   enabled = true,
   autocomplete = true,
   debug = false,
   min_length = 1,
   preselect = "enable",
   throttle_time = 80,
   source_timeout = 200,
   incomplete_delay = 400,
   max_abbr_width = 100,
   max_kind_width = 100,
   max_menu_width = 100,
   documentation = {
     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
     winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
     max_width = 120,
     min_width = 60,
     max_height = math.floor(vim.o.lines * 0.3),
     min_height = 1,
   },
   -- documentation = true,
   source = {
      path = {
        kind = "",
        true
      },
      buffer = {
        kind = "﬘",
        true
      },
      calc = {
        kind = "",
        true
      },
      vsnip = {
        kind = " ",
        true
      },
      nvim_lsp = {
        kind = "",
        true
      },
      nvim_lua = true,
      spell = {
        kind = "",
        true
      },
      emoji = {
        kind = "ﲃ",
        filetypes = { "markdown", "text" }
      },
      luasnip = { 
        kind = "﬌",
        true },
      tabnine = {
        kind = "☭",
        true
      },
      tags = false,
      vim_dadbod_completion = false,
      snippets_nvim = false,
      ultisnips = false,
      treesitter = false,
   },
}

