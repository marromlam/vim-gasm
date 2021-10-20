local M = {}


M.config = function()
  local status_ok, snap = pcall(require, "snap")
  if not status_ok then
    return
  end


local file = snap.config.file:with {reverse = true, suffix = ">>", consumer = "fzf"}
local vimgrep = snap.config.vimgrep:with {reverse = true, suffix = ">>", limit = 50000}


snap.maps {
  {"<Leader><Leader>", snap.config.file {producer = "ripgrep.file"}, {command = "ripgrepfile"}},
  {"<Leader>sb", snap.config.file {producer = "vim.buffer"}, {command = "buffers"}},
  {"<Leader>so", snap.config.file {producer = "vim.oldfile"}, {command = "oldfiles"}},
  {"<Leader>sf", snap.config.vimgrep {}, {command = "nose",}},
}


snap.register.map({'n'}, {'<space>sg'},
  function()
    snap.run({
        prompt = '❯',
        producer = snap.get'consumer.fzf'(snap.get'producer.git.general'.args {"--status"}),
        select = snap.get'select_file'.select,
        multiselect = snap.get'select_file'.multiselect
    })
 end
)




local icons = require 'nvim-web-devicons'
require('nvim-web-devicons').setup { default = true }


local fnamemodify = vim.fn.fnamemodify
local get_icon = icons.get_icon
local function add_icon(meta_result)
  local filename = fnamemodify(meta_result.result, ':t:r')
  local extension = fnamemodify(meta_result.result, ':e')
  local icon = get_icon(filename, extension)
  return icon .. ' ' .. meta_result.result
end


local function icons_consumer(producer)
  return function(request)
    for results in snap.consume(producer, request) do
      if type(results) == 'table' then
        if not vim.tbl_islist(results) then
          coroutine.yield(results)
        else
          coroutine.yield(vim.tbl_map(function(result)
            return snap.with_metas(result, { display = add_icon, highlight_offset = 4 })
          end, results))
        end
      else
        coroutine.yield(nil)
      end
    end
  end
end


snap.register.map('n', '<Leader>ss',
  snap.create(
    function()
      return {
        prompt = 'Git Files',
        producer = snap.get'consumer.fzf'(
          snap.get'consumer.try'(
            snap.get'producer.git.file',
            snap.get'producer.ripgrep.file'
          )
        ),
        select = snap.get'select.file'.select,
        multiselect = snap.get'select.file'.multiselect,
        views = {snap.get'preview.file'},
      }
    end
  )
)


snap.register.map( 'n', '<Leader>sG',
  snap.create(
    function()
      return {
        prompt = 'Git Files',
        producer = icons_consumer(snap.get 'consumer.fzf'(snap.get 'producer.fd.file')),
        select = snap.get('select.file').select,
        multiselect = snap.get('select.file').multiselect,
        views = { snap.get 'preview.file' },
      }
  end)
)


snap.register.map( 'n', '<Leader>sl',
  snap.create(function()
    return {
      prompt = 'Ripgrep',
      producer = icons_consumer(snap.get 'consumer.limit'(50000, snap.get 'producer.ripgrep.vimgrep')),
      -- producer = icons_consumer(snap.get 'consumer.limit'(50000, snap.get'consumer.fzy'(snap.get'producer.ripgrep.vimgrep'))),
      select = snap.get('select.vimgrep').select,
      multiselect = snap.get('select.vimgrep').multiselect,
      views = { snap.get 'preview.vimgrep' },
    }
  end)
)


snap.register.map( 'n', '<leader>sb',
  snap.create(function()
    return {
      prompt = 'Buffers ❯',
      producer = icons_consumer(snap.get 'consumer.fzf'(snap.get 'producer.vim.buffer')),
      select = snap.get('select.file').select,
      multiselect = snap.get('select.file').multiselect,
      views = { snap.get 'preview.file' },
      layout = function()
          local lines = vim.api.nvim_get_option("lines")
          local height = math.floor((lines * 0.5))
          local width = (vim.api.nvim_get_option("columns") - 10)
          return {col = 10, row = (lines - height - 4), height = height, width = width}
  end,
    }
  end)
)
end


return M

-- vim:foldmethod=marker
