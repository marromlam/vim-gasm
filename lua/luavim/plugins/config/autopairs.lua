local present, autopairs = pcall(require, "nvim-autopairs")
if not present then
	return
end

autopairs.setup({ check_ts = true, ts_config = {} })

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local present, cmp = pcall(require, "cmp")
if not present then
	return
end
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({  map_char = { tex = '' } })
)


-- vim:foldmethod=marker
