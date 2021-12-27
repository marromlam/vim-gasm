local present, bufferline = pcall(require, "bufferline")
if not present then
	return
end

bufferline.setup({
	options = { -- {{{
		offsets = {
			{ filetype = "NvimTree", text = "", gui = "bold", padding = 1 },
		},
		modified_icon = "",
		numbers = "ordinal",
		indicator_icon = "▎",
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		-- close icon
		close_icon = "",
		show_close_icon = false,
		-- buffer name lenght and truncation
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 20,
		-- show_tab_indicators = true,
		-- enforce_regular_tabs = false,
		view = "multiwindow",
		-- buffer close icon
		buffer_close_icon = "",
		show_buffer_close_icons = true,
		-- separator_style = {"/", "\\"},
		--mappings = true,
		always_show_bufferline = true,
		diagnostics = false, -- "or nvim_lsp"
		show_buffer_icons = true,
		persist_buffer_sort = true,
		enforce_regular_tabs = true,
	}, -- }}}
	highlights = { -- {{{
		fill = {
			guifg = { attribute = "fg", highlight = "#ff0000" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},
		background = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},

		-- buffer_selected = {
		--   guifg = {attribute='fg',highlight='#ff0000'},
		--   guibg = {attribute='bg',highlight='#0000ff'},
		--   gui = 'none'
		--   },
		buffer_visible = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},

		close_button = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},
		close_button_visible = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},

		-- close_button_selected = {
		--   guifg = {attribute='fg',highlight='TabLineSel'},
		--   guibg ={attribute='bg',highlight='TabLineSel'}
		--   },

		tab_selected = {
			guifg = { attribute = "fg", highlight = "Normal" },
			guibg = { attribute = "bg", highlight = "Normal" },
		},
		tab = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},
		tab_close = {
			guifg = { attribute = "fg", highlight = "TabLineSel" },
			guibg = { attribute = "bg", highlight = "Normal" },
		},

		duplicate_selected = {
			guifg = { attribute = "fg", highlight = "TabLineSel" },
			guibg = { attribute = "bg", highlight = "TabLineSel" },
			gui = "italic",
		},
		duplicate_visible = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
			gui = "italic",
		},
		duplicate = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
			gui = "italic",
		},

		modified = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},
		modified_selected = {
			guifg = { attribute = "fg", highlight = "Normal" },
			guibg = { attribute = "bg", highlight = "Normal" },
		},
		modified_visible = {
			guifg = { attribute = "fg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},

		separator = {
			guifg = { attribute = "bg", highlight = "TabLine" },
			guibg = { attribute = "bg", highlight = "TabLine" },
		},
		separator_selected = {
			guifg = { attribute = "bg", highlight = "Normal" },
			guibg = { attribute = "bg", highlight = "Normal" },
		},
		-- separator_visible = {
		--   guifg = {attribute='bg',highlight='TabLine'},
		--   guibg = {attribute='bg',highlight='TabLine'}
		--   },

		indicator_selected = {
			guifg = { attribute = "fg", highlight = "Normal" },
			guibg = { attribute = "bg", highlight = "Normal" },
		},
	}, -- }}}
})

-- vim:fdm=marker
