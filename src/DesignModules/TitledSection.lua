----------------------------------------
--
-- TitleBarClass
--
-- Creates a section with a title label:
--
-- "SectionXXX"
--     "TitleBarVisual"
--     "Contents"
--
-- Requires "parent" and "sectionName" parameters and returns the section and its contentsFrame
-- The entire frame will resize dynamically as contents frame changes size.
--
-- "autoScalingList" is a boolean that defines wheter or not the content frame automatically resizes when children are added.
-- This is important for cases when you want minimize button to push or contract what is below it.
--
-- Both "minimizeable" and "minimizedByDefault" are false by default
-- These parameters define if the section will have an arrow button infront of the title label, 
-- which the user may use to hide the section's contents
--
----------------------------------------
GuiUtilities = require(script.Parent.GuiUtilities)

local kRightButtonAsset = "rbxasset://textures/TerrainTools/button_arrow.png"

local kArrowSize = 9

TitleBarClass = {}
TitleBarClass.__index = TitleBarClass


function TitleBarClass.new(nameSuffix, titleText)
	local self = {}
	setmetatable(self, TitleBarClass)

	self._titleBarHeight = GuiUtilities.kTitleBarHeight

	local frame = Instance.new('Frame')
	frame.Name = 'CTSection' .. nameSuffix
	frame.BackgroundTransparency = 1
	self._frame = frame
	self:_CreateTitleBar(titleText)
	
	return self

	end
function TitleBarClass:GetSectionFrame()
	return self._frame
end

function TitleBarClass:_UpdateSize()
	local totalSize = self._uiListLayout.AbsoluteContentSize.Y
	self._frame.Size = UDim2.new(1, 0, 0, totalSize)
end

function TitleBarClass:SetCollapsedState(bool)
	self._minimized = bool
	self._contentsFrame.Visible = not bool
	self:_UpdateMinimizeButton()
	self:_UpdateSize()
end

function TitleBarClass:_CreateTitleBar(titleText)
	local titleTextOffset = self._titleBarHeight

	local titleBar = Instance.new('ImageButton')
	titleBar.AutoButtonColor = false
	titleBar.Name = 'TitleBarVisual'
	titleBar.BorderSizePixel = 0
	titleBar.Position = UDim2.new(0, 0, 0, 0)
	titleBar.Size = UDim2.new(1, 0, 0, self._titleBarHeight)
	titleBar.Parent = self._frame
	titleBar.LayoutOrder = 1
	GuiUtilities.syncGuiElementTitleColor(titleBar)

	local titleLabel = Instance.new('TextLabel')
	titleLabel.Name = 'TitleLabel'
	titleLabel.BackgroundTransparency = 1
	titleLabel.Font = Enum.Font.SourceSansBold                --todo: input spec font
	titleLabel.TextSize = 15                                  --todo: input spec font size
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Text = titleText
	titleLabel.Position = UDim2.new(0, titleTextOffset, 0, 0)
	titleLabel.Size = UDim2.new(1, -titleTextOffset, 1, GuiUtilities.kTextVerticalFudge)
	titleLabel.Parent = titleBar
	GuiUtilities.syncGuiElementFontColor(titleLabel)

	self._minimizeButton = Instance.new('ImageButton')
	self._minimizeButton.Name = 'MinimizeSectionButton'
	self._minimizeButton.Image = kRightButtonAsset              --todo: input arrow image from spec
	self._minimizeButton.Size = UDim2.new(0, kArrowSize, 0, kArrowSize)
	self._minimizeButton.AnchorPoint = Vector2.new(0.5, 0.5)
	self._minimizeButton.Position = UDim2.new(0, self._titleBarHeight*.5,
		 0, self._titleBarHeight*.5)
	self._minimizeButton.BackgroundTransparency = 1
	self._minimizeButton.Visible  = true

		end

return TitleBarClass