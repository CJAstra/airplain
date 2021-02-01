local PluginBar = plugin:CreateToolbar("Airplain") --Replace "Plugin" with the name of your plugin.
local PluginButton1 = PluginBar:CreateButton("TheHub", "Access to the Suite", "rbxassetid://6323160799", "Hub") --Button identifier, button description, button icon (Optional), button name.
local CustomTextButton = require(script.DesignModules.CustomTextButton)
local DropdownMenu = require(script.DesignModules.DropdownMenu)
local TitledSection = require(script.DesignModules.TitledSection)

-- Plugin Widget
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Left,  -- Widget will be initialized in floating panel
	true,   -- Widget will be initially enabled
	true,  -- Don't override the previous enabled state
	10,    -- Default width of the floating window
	10,    -- Default height of the floating window
	200,    -- Minimum width of the floating window
	200    -- Minimum height of the floating window
)
-- Create new widget GUI
local Hub = plugin:CreateDockWidgetPluginGui("Airplain", widgetInfo)


Hub.Title = "Airplain"  -- Optional widget title


PluginButton1.Click:Connect(function()
	Hub.Enabled = not Hub.Enabled
end)
--Title Bar
local title = TitledSection.new(
	"Suffix1",
	"Airplain by astraran"
)
-- Dropdown Menu
-- selections require 3 inputs: display text, value to return, and a unique identifier.
-- display text and id must both be strings.
-- id must be unique, or a warning will be thrown, and that selection will not be added.
-- return value may be any value such as an int, number, string, bool, table, etc. 
local selectionTable = {
	--  {"display text", "return value", "id"}
	{"Tasks", 1, "1"},
	{"WhiteBoard", 2, "2"},
	{"Notepad", 3, "3"},
}

local dropdown = DropdownMenu.new(
	"suffix", -- name suffix of gui object
	"Label text", -- displayed label text
	selectionTable -- table of selection data, optional
)


-- change the label text
dropdown:ChangeLabel("Choose a Tool")


dropdown:GetSectionFrame().Parent = Hub
--Color Stuff
local function syncGuiColors(objects)
	local function setColors()
		for _, guiObject in pairs(objects) do
			-- Sync background color
			guiObject.BackgroundColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
			-- Sync text color
			guiObject.TextColor3 = settings().Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainText)
		end
	end
	-- Run 'setColors()' function to initially sync colors
	setColors()
	-- Connect 'ThemeChanged' event to the 'setColors()' function
	settings().Studio.ThemeChanged:Connect(setColors)
end

-- Run 'syncGuiColors()' function to sync colors of provided objects
syncGuiColors({Hub:GetChildren()})
