local present1, cmp = pcall(require, "cmp")
if not present1 then
  print("miss cmp")
	return
end
local present2, luasnip = pcall(require, "luasnip")
if not present2 then
  print("miss luasnip")
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end


-- TODO: maybe in the future it would be nice to have a tab
-- function wrapper or so


-- define icons for cmp {{{
--   פּ ﯟ  
-- https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- }}}


-- buffer setup {{{

cmp.setup({
	mapping = {
    -- next and previuous item without arrows
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- scroll docs without mouse
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- complete
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({ i=cmp.mapping.abort(), c=cmp.mapping.close() }),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),  -- WARN

    -- tab functions {{{
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
    -- }}}
	},
	formatting = {
    deprecated = true,
		fields = { "kind", "abbr", "menu" },
    -- format function when displaying completions {{{
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- tab nine completion
      if entry.source.name == 'cmp_tabnine' then
        vim_item.kind = ''
      end
      if entry.source.name == 'copilot' then
        vim_item.kind = 'ﯙ'
      end
      -- Menu item provider
      vim_item.menu = ({
       nvim_lsp = '[LSP]',
       nvim_lua = '[Lua]',
       emoji = '[Emoji]',
       path = '[Path]',
       calc = '[Calc]',
       neorg = '[Neorg]',
       orgmode = '[Org]',
       cmp_tabnine = '[TN]',
       copilot = '[Copilot]',
       luasnip = '[Snip]',
       buffer = '[Buffer]',
       fuzzy_buffer = '[Fuzzy Buffer]',
       fuzzy_path = '[Fuzzy Path]',
       spell = '[Spell]',
       cmdline = '[Command]',
       cmp_git = '[Git]',
      })[entry.source.name]

      return vim_item
		end,
    -- }}}
	},
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'copilot' },
    { name = 'cmp_tabnine' },
    { name = 'spell' },
    { name = 'path' },
    { name = 'neorg' },
    { name = 'orgmode' },
    { name = 'cmp_git' },
  }, {
    { name = 'fuzzy_buffer' },
  }),
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  -- provide snippets
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
  -- when using copilot this should be used
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

-- }}}


-- Command mode completion (NEW) {{{
local search_sources = {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
  }, {
    { name = 'fuzzy_buffer' },
  }),
}
cmp.setup.cmdline('/', search_sources)
cmp.setup.cmdline('?', search_sources)
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'fuzzy_path' },
  }, {
    { name = 'cmdline' },
  }),
})

-- }}}


-- vim:foldmethod=marker
