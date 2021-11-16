local _test, gl = pcall(require, "galaxyline")
if not _test then
  print("galaxyline not found")
  return
end

local gls = gl.section
-- local hsl = require("lush.hsl")

local cpresent, c = pcall(require, vim.g.theme .. ".colors")
if not cpresent then
    print("not present")
    print(c.bg0_alt)
    return
end

gl.short_line_list = {
    "LuaTree", "NvimTree", "vista", "dbui", "startify", "term", "nerdtree",
    "netrw", "fugitive", "fugitiveblame", "plug", "packer", "Dashboard",
    "dashboard"
}


local use_coc = false
if vim.g.nerd_galaxyline_lsp == "coc" then
  use_coc = true
end

local function lsp_status(status)
  local shorter_stat = ""
  for match in string.gmatch(status, "[^%s]+")  do
    local err_warn = string.find(match, "^[WE]%d+", 0)
    if not err_warn then
      shorter_stat = shorter_stat .. " " .. match
    end
  end
  return shorter_stat
end


local function get_coc_lsp()
  local status = vim.fn["coc#status"]()
  if not status or status == "" then
      return ""
  end
  return lsp_status(status)
end


local function get_diagnostic_info()
  if vim.fn.exists("*coc#rpc#start_server") == 1 then
    return get_coc_lsp()
    end
  return ""
end


local function get_current_func()
  local has_func, func_name = pcall(vim.fn.nvim_buf_get_var, 0, "coc_current_function")
  if not has_func then return end
      return func_name
  end


local function get_function_info()
  if vim.fn.exists("*coc#rpc#start_server") == 1 then
    return get_current_func()
    end
  return ""
end


local function trailing_whitespace()
    local trail = vim.fn.search("\\s$", "nw")
    if trail ~= 0 then
        return " "
    else
        return nil
    end
end

CocStatus = get_diagnostic_info
CocFunc = get_function_info
TrailingWhiteSpace = trailing_whitespace

local function has_file_type()
    local f_type = vim.bo.filetype
    if not f_type or f_type == "" then
        return false
    end
    return true
end

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

-- insert_left insert item at the left panel
local function insert_left(element)
  table.insert(gls.left, element)
end

-- insert_blank_line_at_left insert blank line with
-- dark0_soft.hex color.
local function insert_blank_line_at_left()
insert_left {
  Space = {
    provider = function () return " " end,
    highlight = {c.dark0_soft.hex,c.dark0_soft.hex}
  }
}
end

-- insert_right insert given item into galaxyline.right
local function insert_right(element)
  table.insert(gls.right, element)
end

-- insert_blank_line_at_left insert blank line with
-- dark0_soft.hex color.
local function insert_blank_line_at_right()
insert_right {
  Space = {
    provider = function () return " " end,
    highlight = {c.dark0_soft.hex,c.dark0_soft.hex}
  }
}
end









-- Active window

-- Left {{{1

insert_left{
  Space = {
    provider = function() return " " end,
    highlight = {c.dark0_soft.hex,c.dark0_soft.hex}
  }
}

-- insert_blank_line_at_left()


-- insert_left{
--   Separa = {
--     provider = function() return "" end,
--     highlight = {c.dark0_soft.hex, },
--   }
-- }

--mode panel end}

-- {information panel start
-- insert_left{
--   Start = {
--     provider = function() return "" end,
--     highlight = {c.dark0_soft.hex,}
--   }
-- }


-- File name {{{2

insert_left{
  FileIcon = {
    provider = "FileIcon",
    condition = buffer_not_empty,
    highlight = {c.neutral_blue.hex , c.dark0_soft.hex},
  },
}

insert_left{
  FileName = {
    provider = function()
      return vim.fn.expand("%:F")
    end,
    condition = function()
      return buffer_not_empty and has_file_type()
    end,
    highlight = {c.light0_soft.hex, c.dark0_soft.hex}
  }
}

-- }}}


insert_blank_line_at_left()


-- Git integration {{{2

insert_left {
  GitIcon = {
    provider = function() return "   " end,
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    highlight = {c.neutral_blue.hex, c.dark0_soft.hex},
  }
}

insert_left {
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    highlight = {c.neutral_blue.hex, c.dark0_soft.hex, "bold"},
  }
}

insert_blank_line_at_left()

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

insert_left {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = "  ",
    highlight = {c.neutral_green.hex, c.dark0_soft.hex},
  }
}

insert_left {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "  ",
    highlight = {c.neutral_yellow.hex, c.dark0_soft.hex},
  }
}

insert_left {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "  ",
    highlight = {c.neutral_red.hex,c.dark0_soft.hex},
  }
}

insert_left {
    TrailingWhiteSpace = {
     provider = TrailingWhiteSpace,
     icon = "  ",
     highlight = {c.yellow.hex, c.dark0_soft.hex},
    }
}

-- }}}

insert_left {
  Space = {
    provider = function() return "" end,
    highlight = {c.neutral_red.hex,c.dark0_soft.hex}
  }
}

-- Diagnosis {{{2

insert_left {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = {c.neutral_red.hex,c.dark0_soft.hex}
  }
}

insert_left {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = {c.yellow.hex, c.dark0_soft.hex},
  }
}

insert_left {
    CocStatus = {
     provider = CocStatus,
     highlight = {c.neutral_green.hex, c.dark0_soft.hex},
     icon = "  ",
		 condition = use_coc,
    }
}

insert_left {
    CocStatus = {
     provider = "DiagnosticInfo",
     highlight = {c.neutral_green.hex, c.dark0_soft.hex},
     icon = "  ",
		 condition = function() return checkwidth() and not use_coc end,
    }
}

insert_left {
  CocFunc = {
    provider = CocFunc,
    icon = " λ ",
    highlight = {c.yellow.hex, c.dark0_soft.hex},
		condition = use_coc,
  }
}

insert_left {
	DiagnosticHint = {
	 provider = "DiagnosticHint",
	 condition = function() return checkwidth() and not use_coc end,
	 highlight = {c.light0.hex, c.dark0_soft.hex},
	 icon = "  ",
	}
}

-- }}}

-- }}}


-- Right {{{1

insert_left{
  Separa = {
    provider = function() return " " end,
    highlight = {c.dark0_soft.hex, c.dark0_soft.hex},
  }
}
-- left information panel end}

insert_right{
  Start = {
    provider = function() return " " end,
    highlight = {c.dark0_soft.hex,c.dark0_soft.hex}
  }
}

insert_blank_line_at_right()

insert_right{
  ViMode = {
    icon = function()
        local icons = {
            n      = "🅝",
            i      = "🅘",
            c      = "🅒",
            V      = "🅥",
            [""] = "🅥",
            v      = "🅥",
            C      = "🅒",
            R      = "🅡",
            t      = "🅣",
        }
        return icons[vim.fn.mode()]-- .. " "
      end,
    provider = function()
      -- auto change color according the vim mode
      local alias = {
          n      = " ",
          i      = " ",
          c      = " ",
          V      = " ",
          [""] = " ",
          v      = " ",
          C      = " ",
          ["r?"] = ":CONFIRM",
          rm     = "--MORE",
          R      = " ",
          Rv     = " ",
          s      = " ",
          S      = " ",
          ["r"]  = "HIT-ENTER",
          [""] = "SELECT",
          t      = "" ,
          ["!"]  = "SH",
      }
      local mode_color = {n = c.bright_blue.hex, i = c.bright_green.hex, v=c.bright_blue.hex,
                          [""] = c.bright_blue.hex, V=c.bright_blue.hex,
                          c = c.bright_purple.hex, no = c.bright_red.hex,s = c.bright_orange.hex,
                          S=c.bright_orange.hex, [""] = c.bright_orange.hex,
                          ic = c.bright_yellow.hex, R = c.bright_purple.hex, Rv = c.bright_purple.hex,
                          cv = c.bright_red.hex,ce=c.bright_red.hex, r = c.bright_blue.hex,
                          rm = c.bright_blue.hex, ["r?"] = c.bright_blue.hex,
                          ["!"]  = c.bright_red.hex,t = c.bright_red.hex}

      local vim_mode = vim.fn.mode()
      vim.api.nvim_command("hi GalaxyViMode guifg="..mode_color[vim_mode])
      return alias[vim_mode]
    end,
    highlight = {c.dark0_soft.hex, c.dark0_soft.hex},
  },
}

-- insert_blank_line_at_right()

-- insert_right{
--   FileFormat = {
--     provider = "FileFormat",
-- 		condition = checkwidth,
--     highlight = {c.fg,c.dark0_soft.hex,"bold"},
--   }
-- }

insert_blank_line_at_right()

insert_right{
  LineInfo = {
    provider = "LineColumn",
    separator = "",
    separator_highlight = {c.neutral_green.hex, c.dark0_soft.hex},
    highlight = {c.light0.hex,c.dark0_soft.hex},
		condition = checkwidth,
  },
}

insert_right{
  PerCent = {
    provider = "LinePercent",
    separator = "",
    separator_highlight = {c.neutral_blue.hex, c.dark0_soft.hex},
    highlight = {c.bright_blue.hex, c.dark0_soft.hex,"bold"},
		condition = checkwidth,
  }
}

-- insert_right{
--   Encode = {
--     provider = "FileEncode",
--     separator = "",
--     separator_highlight = {c.blue,c.dark0_soft.hex},
--     highlight = {c.cyan, c.dark0_soft.hex,"bold"},
-- 		condition = checkwidth,
--   }
-- }

insert_blank_line_at_right()

insert_right{
  Right = {
    provider = function() return "" end,
    highlight = {c.dark0_soft.hex, },
  }
}

-- }}}


-- Inactive window

-- Left {{{1

-- insert_blank_line_at_short_left()
gls.short_line_left[0] = {
  Left = {
    provider = function() return "" end,
    highlight = {c.dark0_soft.hex,}
  }
}

gls.short_line_left[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    condition = buffer_not_empty,
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color,c.dark0_soft.hex},
  },
}

gls.short_line_left[2] = {
  BufferType = {
    provider = function()
      return vim.fn.expand("%:F")
    end,
    condition = function() return buffer_not_empty and has_file_type() end,
    highlight = {c.light0.hex,c.dark0_soft.hex}
  }
}

-- }}}


-- Right {{{1

-- gls.short_line_right[0] = {
-- 	Separa = {
-- 		provider = function() return "█" end,
-- 		highlight = {c.dark0_soft.hex,c.dark0_soft.hex}
-- 	}
-- }

gls.short_line_right[1] = {
  Separa = {
    provider = function() return " " end,
    highlight = {c.dark0_soft.hex,c.dark0_soft.hex}
  }
}

-- gls.short_line_right[0] = {
--   Space = {
--     provider = function () return " " end,
--     highlight = {colors.dark0_soft.hex,colors.dark0_soft.hex}
--   }
-- }

-- insert_blank_line_at_short_right()

-- }}}


-- vim:foldmethod=marker

