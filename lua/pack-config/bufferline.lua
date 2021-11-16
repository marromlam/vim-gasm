local present, bufferline = pcall(require, "bufferline")
if not present then
    return
end

local cpresent, c = pcall(require, vim.g.theme .. ".colors")
if not cpresent then
    print("not present")
    return
end

bufferline.setup {
    options = {
        offsets = {{filetype = "NvimTree", text = "File Explorer", highlight="NvimTreeHeader", gui = "bold", padding = 1}},
        buffer_close_icon = "",
        modified_icon = "",
        numbers = "ordinal",
        close_icon = "",
        show_close_icon = false,
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        -- show_tab_indicators = true,
        -- enforce_regular_tabs = false,
        -- view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        -- separator_style = {"/", "\\"},
        --mappings = true,
        -- always_show_bufferline = true
    },
    -- highlights = {
    --   -- fill is the color of the bufferline (set to be the same as galaxyline)
    --   fill = { guifg=c.light0.hex, guibg=c.dark0_soft.hex },
    --   -- this is the default skin of a buffer tab
    --   background = { guifg = c.light0.hex, guibg = c.dark0_soft.hex },
    --   -- buffers
    --   buffer_visible = { guifg = c.light0.hex, guibg = c.dark0.hex },
    --   buffer_selected = { guifg = c.light0.hex, guibg = c.dark0.hex, gui = "bold" },
    -- --   -- tabs
    -- --   tab = { guifg = colors.accent, guibg = colors.red },
    -- --   tab_selected = { guifg = colors.accent, guibg = colors.bg },
    -- --   -- this is a close buttom at right of bufferline (disabled)
    -- --   tab_close = { guifg = colors.accent, guibg = colors.dark },
    -- --   -- indicator is a vert before buffer tab
    -- --   indicator_selected = { guifg = colors.bg, guibg = colors.bg },
    -- -- separators
    -- separator             = { guifg = c.light0.hex, guibg = c.dark0_soft.hex },
    -- separator_visible     = { guifg = c.light0.hex, guibg = c.dark0.hex },
    -- separator_selected    = { guifg = c.light0.hex, guibg = c.dark0.hex },
    -- --   -- modified
    -- --   modified = { guifg = colors.accent, guibg = colors.dark },
    -- --   modified_visible = { guifg = colors.red, guibg = colors.bg },
    -- --   modified_selected = { guifg = colors.red, guibg = colors.bg },
    -- -- close buttons
    -- close_button          = { guifg = c.light0_soft.hex, guibg = c.dark0_soft.hex },
    -- close_button_visible  = { guifg = c.light0_soft.hex, guibg = c.dark0.hex },
    -- close_button_selected = { guifg = c.light0_soft.hex, guibg = c.dark0.hex }
    -- }
}
