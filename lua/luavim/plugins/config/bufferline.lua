local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end


bufferline.setup {
  options = {
    offsets = {
      { filetype = "NvimTree", text = "", gui = "bold", padding = 1}
    },
    modified_icon = "",
    numbers = "ordinal",
    indicator_icon = '▎',
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
    separator_style = "thin",
    -- separator_style = {"/", "\\"},
    --mappings = true,
    always_show_bufferline = true,
    diagnostics = false, -- "or nvim_lsp"
    show_buffer_icons = true,
    persist_buffer_sort = true,
    enforce_regular_tabs = true,
  },
}

