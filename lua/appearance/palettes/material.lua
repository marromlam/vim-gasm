-- MATERIAL color palette


local colors = {

  white    = '#EEFFFF',
  gray     = '#717CB4',
  black    = '#000000',
  red      = '#F07178',
  green    = '#C3E88D',
  yellow   = '#FFCB6B',
  blue     = '#82AAFF',
  paleblue = '#B0C9FF',
  cyan     = '#89DDFF',
  purple   = '#C792EA',
  orange   = '#F78C6C',
  pink     = '#FF9CAC',

  error    = '#FF5370',
  link     = '#80CBC4',
  cursor   = '#FFCC00',

  none     = 'NONE'

}


if vim.g.colors_style == 'darker' then
  colors.bg =			'#212121'
  colors.bg_alt =			'#212121'
  colors.line_bg =		'#1A1A1A'
  colors.fg =			'#B0BEC5'
  colors.text =			'#727272'
  colors.comments =		'#616161'
  colors.selection = 	'#404040'
  colors.contrast =		'#1A1A1A'
  colors.active =		'#323232'
  colors.border =		'#292929'
  colors.line_numbers =	'#424242'
  colors.highlight =	'#3F3F3F'
  colors.disabled =		'#474747'
  colors.accent =		'#FF9800'
  if vim.g.colors_darker_contrast == true then
    colors.comments =		'#757575'
    colors.line_numbers =	'#5C5C5C'
  end
elseif vim.g.colors_style == 'lighter' then
  if vim.g.colors_lighter_contrast == true then
    colors.bg =			'#FAFAFA'
    colors.alt_bg =		'#FAFAFA'
    colors.line_bg =		'#FFFFFF'
    colors.fg =			'#213B47' -- 20% darkened
    colors.text =			'#61747D' -- 20% darkened
    colors.comments =		'#778C96' -- 20% darkened
    colors.selection = 	'#e2e9e9' -- 15% saturation, 10% lightness
    colors.contrast =		'#EEEEEE'
    colors.active =		'#E7E7E8'
    colors.border =		'#D3E1E8'
    colors.line_numbers =	'#B6BFC3' -- 10% darkened
    colors.highlight =	'#E7E7E8'
    colors.disabled =		'#D2D4D5'
    colors.cursor =		'#272727'
    colors.accent =		'#0089A1' -- 20% darkened
    colors.white =		'#FFFFFF'
    colors.gray = 		'#717CB4'
    colors.black =		'#000000'
    colors.red =  		'#B20602' -- 20% darkened
    colors.green =		'#5E8526' -- 20% darkened
    colors.yellow =		'#C37101' -- 20% darkened
    colors.blue = 		'#2E4F85' -- 20% darkened
    colors.paleblue =		'#54637D' -- 20% darkened
    colors.cyan = 		'#067A82' -- 20% darkened
    colors.purple =		'#491ACC' -- 20% darkened
    colors.orange =		'#C43A14' -- 20% darkened
    colors.pink = 		'#CC203D' -- 20% darkened
  else
    colors.bg =			'#FAFAFA'
    colors.bg_alt =			'#FAFAFA'
    colors.line_bg =		'#FFFFFF'
    colors.fg =			'#546E7A'
    colors.text =			'#94A7B0'
    colors.comments =		'#AABFC9'
    colors.selection = 	'#80CBC4'
    colors.contrast =		'#EEEEEE'
    colors.active =		'#E7E7E8'
    colors.border =		'#D3E1E8'
    colors.line_numbers =	'#CFD8DC'
    colors.highlight =	'#E7E7E8'
    colors.disabled =		'#D2D4D5'
    colors.cursor =		'#272727'
    colors.accent =		'#00BCD4'
    colors.white =		'#FFFFFF'
    colors.gray = 		'#717CB4'
    colors.black =		'#000000'
    colors.red =  		'#E53935'
    colors.green =		'#91B859'
    colors.yellow =		'#F6A434'
    colors.blue = 		'#6182B8'
    colors.paleblue =		'#8796B0'
    colors.cyan = 		'#39ADB5'
    colors.purple =		'#7C4DFF'
    colors.orange =		'#F76D47'
    colors.pink = 		'#FF5370'
  end
elseif vim.g.colors_style == 'palenight' then
  colors.bg =			'#292D3E'
  colors.bg_alt =			'#292D3E'
  colors.line_bg =		'#1B1E2B'
  colors.fg =			'#A6ACCD'
  colors.text =			'#717CB4'
  colors.comments =		'#676E95'
  colors.selection = 	'#444267'
  colors.contrast =		'#202331'
  colors.active =		'#414863'
  colors.border =		'#676E95'
  colors.line_numbers =	'#3A3F58'
  colors.highlight =	'#444267'
  colors.disabled =		'#515772'
  colors.accent =		'#AB47BC'
elseif vim.g.colors_style == 'deep ocean' then
  colors.bg =			'#0F111A'
  colors.bg_alt =			'#0F111A'
  colors.line_bg =		'#090B10'
  colors.fg =			'#8F93A2'
  colors.text =			'#717CB4'
  colors.comments =		'#464B5D'
  colors.selection = 	'#1F2233'
  colors.contrast =		'#090B10'
  colors.active =		'#1A1C25'
  colors.border =		'#1f2233'
  colors.line_numbers =	'#3B3F51'
  colors.highlight =	'#1F2233'
  colors.disabled =		'#464B5D'
  colors.accent =		'#84FFFF'
else vim.g.colors_style = 'oceanic'
  colors.bg =			'#263238'
  colors.bg_alt =			'#263238'
  colors.line_bg =		'#192227'
  colors.fg =			'#B0BEC5'
  colors.text =			'#607D8B'
  colors.comments =		'#546E7A'
  colors.selection = 	'#464B5D'
  colors.contrast =		'#1E272C'
  colors.active =		'#314549'
  colors.border =		'#2A373E'
  colors.line_numbers =	'#37474F'
  colors.highlight =	'#425B67'
  colors.disabled =		'#415967'
  colors.accent =		'#009688'
  colors.dark =		'#263242'
end

-- -- Optional colors
--
-- -- Enable contrast sidebars, floating windows and popup menus
-- if vim.g.colors_contrast == false then
--     colors.sidebar = colors.bg
--     colors.float = colors.bg
-- else
--     colors.sidebar = colors.bg_alt
--     colors.float = colors.bg_alt
-- end
--
-- -- Enable custom variable colors
-- if vim.g.colors_variable_color == nil then
--     colors.variable = colors.gray
-- else
--     colors.variable = vim.g.colors_variable_color
-- end
--
-- -- Set black titles for lighter style
-- if vim.g.colors_style == 'lighter' then
--     colors.title = colors.black
-- else
--     colors.title = colors.white
-- end
--
-- -- Apply user defined colors
--
-- -- Check if vim.g.colors_custom_colors = is a table
-- if type(vim.g.colors_custom_colors) == "table" then
-- 	-- Iterate trough the table
-- 	for key, value in pairs(vim.g.colors_custom_colors) do
-- 		-- If the key doesn't exist:
-- 		if not colors[key] then
-- 			error("Color " .. key .. " does not exist")
-- 		end
-- 		-- If it exists and the sting starts with a "#"
-- 		if string.sub(value, 1, 1) == "#" then
-- 			-- Hex override
-- 			colors[key] = value
-- 		-- IF it doesn't, dont accept it
-- 		else
-- 			-- Another group
-- 			if not colors[value] then
-- 			  error("Color " .. value .. " does not exist")
-- 			end
-- 			colors[key] = colors[value]
-- 		end
-- 	end
-- end

return colors

