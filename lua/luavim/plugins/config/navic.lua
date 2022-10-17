return function()
    vim.g.navic_silence = true
    local highlights = require('core.highlights')
    local s = core.style
    local misc = s.icons.misc

    require('core.highlights').plugin('navic', {
        { NavicText = { bold = true } },
        { NavicSeparator = { link = 'Directory' } },
    })
    local icons = core.map(function(icon, key)
        highlights.set(('NavicIcons%s'):format(key), { link = s.lsp.highlights[key] })
        return icon .. ' '
    end, s.current.lsp_icons)

    require('nvim-navic').setup({
        icons = icons,
        highlight = true,
separator = " > ",
    depth_limit = 0,
        --[[ depth_limit_indicator = misc.ellipsis, ]]
        separator = (' %s '):format(misc.arrow_right),
    })
end

