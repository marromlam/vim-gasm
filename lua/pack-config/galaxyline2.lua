local _test, gl = pcall(require, "galaxyline")
if not _test then
  print("galaxyline not found")
  return
end

local gls = gl.section
local hsl = require("lush.hsl")

gl.short_line_list = {
    "LuaTree",
    "NvimTree",
    "vista",
    "dbui",
    "startify",
    "term",
    "nerdtree",
    "netrw",
    "fugitive",
    "fugitiveblame",
    "plug",
    "packer",
    "Dashboard", "dashboard",
}

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
 end

-- local _, colors = pcall(require,  "appearance.palettes." .. "assegonia")
-- local _, _colors = pcall(require,  "appearance.palettes." .. vim.g.colorscheme)
-- local __colors = require("gruvbox.colors")

-- print(dump(__colors))

-- for k,v in pairs(_colors) do colors[k] = v end

local colors = {
  line_bg = "#3c3836",
  red = "#cc241d",
  green = "#98971a",
  yellow = "#d79921",
  blue = "#458588",
  purple = "#b16286",
  cyan = "#689d6a",
 orange =  "#d65d0e",
  magenta = "#9d0006",
  faded_green = "#79740e",
  faded_yellow = "#b57614",
  faded_blue = "#076678",
  violet = "#8f3f71",
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
  local has_func, func_name = pcall(vim.fn.nvim_buf_get_var,0,"coc_current_function")
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
-- line_bg color.
local function insert_blank_line_at_left()
insert_left {
  Space = {
    provider = function () return " " end,
    highlight = {colors.line_bg,colors.line_bg}
  }
}
end

-- insert_right insert given item into galaxyline.right
local function insert_right(element)
  table.insert(gls.right, element)
end

-- insert_blank_line_at_left insert blank line with
-- line_bg color.
local function insert_blank_line_at_right()
insert_right {
  Space = {
    provider = function () return " " end,
    highlight = {colors.line_bg,colors.line_bg}
  }
}
end









-- Active window

-- Left {{{1

insert_left{
  Left = {
    provider = function() return "" end,
    highlight = {colors.line_bg,}
  }
}

-- insert_blank_line_at_left()


-- insert_left{
--   Separa = {
--     provider = function() return "" end,
--     highlight = {colors.line_bg, },
--   }
-- }

--mode panel end}

-- {information panel start
-- insert_left{
--   Start = {
--     provider = function() return "" end,
--     highlight = {colors.line_bg,}
--   }
-- }


-- File name {{{2

insert_left{
  FileIcon = {
    provider = "FileIcon",
    condition = buffer_not_empty,
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color,colors.line_bg},
  },
}

insert_left{
  FileName = {
    provider = function()
      return vim.fn.expand("%:F")
    end,
    condition = function() return buffer_not_empty and has_file_type() end,
    highlight = {colors.fg,colors.line_bg}
  }
}

-- }}}


insert_blank_line_at_left()


-- Git integration {{{2

insert_left {
  GitIcon = {
    provider = function() return "   " end,
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    highlight = {colors.orange,colors.line_bg},
  }
}

insert_left {
  GitBranch = {
    provider = "GitBranch",
    condition = require("galaxyline.provider_vcs").check_git_workspace,
    highlight = {"#8FBCBB",colors.line_bg,"bold"},
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
    highlight = {colors.green,colors.line_bg},
  }
}

insert_left {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = "  ",
    highlight = {colors.orange,colors.line_bg},
  }
}

insert_left {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = "  ",
    highlight = {colors.red,colors.line_bg},
  }
}

insert_left {
    TrailingWhiteSpace = {
     provider = TrailingWhiteSpace,
     icon = "  ",
     highlight = {colors.yellow,colors.line_bg},
    }
}

-- }}}

insert_left {
  Space = {
    provider = function() return "" end,
    highlight = {colors.red,colors.line_bg}
  }
}

-- Diagnosis {{{2

insert_left {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = {colors.red,colors.line_bg}
  }
}

insert_left {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = {colors.yellow,colors.line_bg},
  }
}

insert_left {
    CocStatus = {
     provider = CocStatus,
     highlight = {colors.green,colors.line_bg},
     icon = "  ",
		 condition = use_coc,
    }
}

insert_left {
    CocStatus = {
     provider = "DiagnosticInfo",
     highlight = {colors.green,colors.line_bg},
     icon = "  ",
		 condition = function() return checkwidth() and not use_coc end,
    }
}

insert_left {
  CocFunc = {
    provider = CocFunc,
    icon = " λ ",
    highlight = {colors.yellow,colors.line_bg},
		condition = use_coc,
  }
}

insert_left {
	DiagnosticHint = {
	 provider = "DiagnosticHint",
	 condition = function() return checkwidth() and not use_coc end,
	 highlight = {colors.white,colors.line_bg},
	 icon = "  ",
	}
}

-- }}}

-- }}}


-- Right {{{1

insert_left{
  Separa = {
    provider = function() return "" end,
    highlight = {colors.line_bg, },
  }
}
-- left information panel end}

insert_right{
  Start = {
    provider = function() return "" end,
    highlight = {colors.line_bg,}
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
      local mode_color = {n = colors.yellow, i = colors.green,v=colors.blue,
                          [""] = colors.blue,V=colors.blue,
                          c = colors.magenta,no = colors.red,s = colors.orange,
                          S=colors.orange,[""] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ["r?"] = colors.cyan,
                          ["!"]  = colors.red,t = colors.red}

      local vim_mode = vim.fn.mode()
      vim.api.nvim_command("hi GalaxyViMode guifg="..mode_color[vim_mode])
      return alias[vim_mode]
    end,
    highlight = {colors.line_bg, colors.line_bg},
  },
}

-- insert_blank_line_at_right()

-- insert_right{
--   FileFormat = {
--     provider = "FileFormat",
-- 		condition = checkwidth,
--     highlight = {colors.fg,colors.line_bg,"bold"},
--   }
-- }

insert_blank_line_at_right()

insert_right{
  LineInfo = {
    provider = "LineColumn",
    separator = "",
    separator_highlight = {colors.green, colors.line_bg},
    highlight = {colors.fg,colors.line_bg},
		condition = checkwidth,
  },
}

insert_right{
  PerCent = {
    provider = "LinePercent",
    separator = "",
    separator_highlight = {colors.blue,colors.line_bg},
    highlight = {colors.cyan, colors.line_bg,"bold"},
		condition = checkwidth,
  }
}

-- insert_right{
--   Encode = {
--     provider = "FileEncode",
--     separator = "",
--     separator_highlight = {colors.blue,colors.line_bg},
--     highlight = {colors.cyan, colors.line_bg,"bold"},
-- 		condition = checkwidth,
--   }
-- }

insert_blank_line_at_right()

insert_right{
  Right = {
    provider = function() return "" end,
    highlight = {colors.line_bg, },
  }
}

-- }}}


-- Inactive window

-- Left {{{1

-- insert_blank_line_at_short_left()
gls.short_line_left[0] = {
  Left = {
    provider = function() return "" end,
    highlight = {colors.line_bg,}
  }
}

gls.short_line_left[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    condition = buffer_not_empty,
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color,colors.line_bg},
  },
}

gls.short_line_left[2] = {
  BufferType = {
    provider = function()
      return vim.fn.expand("%:F")
    end,
    condition = function() return buffer_not_empty and has_file_type() end,
    highlight = {colors.fg,colors.line_bg}
  }
}

-- }}}


-- Right {{{1

-- gls.short_line_right[0] = {
-- 	Separa = {
-- 		provider = function() return "█" end,
-- 		highlight = {colors.line_bg,colors.line_bg}
-- 	}
-- }

gls.short_line_right[1] = {
  Separa = {
    provider = function() return "" end,
    highlight = {colors.line_bg,colors.line_bg}
  }
}

-- gls.short_line_right[0] = {
--   Space = {
--     provider = function () return " " end,
--     highlight = {colors.line_bg,colors.line_bg}
--   }
-- }

-- insert_blank_line_at_short_right()

-- }}}


-- vim:foldmethod=marker

