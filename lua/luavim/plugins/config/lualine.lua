local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " ", info = ' '},
	colored = false,
	update_in_insert = false,
	always_visible = true,
  cond = hide_in_width
}

local current_path = {
	"current_path",
  fmt = function ()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end,
  icon = " ",
	colored = false,
  cond = hide_in_width
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " },
  cond = hide_in_width
}

local filename = {
	"filename",
	fmt = function()
    return vim.fn.expand "%:t"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	colored = false,
	-- icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
  icon = '', -- e0a0
}

local location = {
	"location",
  icon = '',
}

local progress = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  -- local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  -- local chars = { "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local chars = { "██", "▇▇","▆▆","▅▅","▄▄","▃▃","▂▂","▁▁","▁▁" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
	return "sp: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "Telescope", "Packer", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch, diff },
		lualine_b = { current_path },
		lualine_c = { filename },
		lualine_x = { spaces, },
		lualine_y = { filetype, diagnostics },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { current_path },
		lualine_c = { filename },
		lualine_x = { location },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
  extensions = {'quickfix', 'fugitive'}
})
