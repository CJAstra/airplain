--
-- Creates a title bar with optional image
--
----------------------------------------
GuiUtilities = require(script.Parent.GuiUtilities)


TitleBar = {}
TitleBar.__index = TitleBar
TitleBar._defaultLength = 189


function TitleBar.new(labelText, nameSuffix)
	local self = {}
local frame = GuiUtilities.MakeStandardFixedHeightFrame("CBF" .. nameSuffix)

	
local label = GuiUtilities.MakeStandardPropertyLabel(labelText, true)
	label.Parent = frame
	

	self._frame = frame
	self._label = label
	local function updateFontColors()
		self:UpdateFontColors()
	end
	settings().Studio.ThemeChanged:connect(updateFontColors)
	updateFontColors()

	return self
	end
function TitleBar:ChangeLabel(labelText)
	assert(type(labelText) == "string", "Expected string. Got "..type(labelText))
	self._titleLabel.Text = labelText
	
end
return TitleBar

	