# Airplain 
Airplain is a Full Suite of Project Management Tools for Roblox Studio. It is in the form of a plugin.

# Bringing the project into studio
The easiest way to bring the project into studio is to use the HttpService to pull the contents directly from this github project into module scripts. After enabling the http service from Game Settings the following code can be run in the command bar.
```lua
local http = game:GetService("HttpService")
local reqmain = http:GetAsync("https://api.github.com/repos/CJAstra/airplain/contents/src")
local reqmod = http:GetAsync("https://api.github.com/repos/CJAstra/airplain/contents/src/DesignModules")
local jsonmain = http:JSONDecode(reqmain)
local jsonmod = http:JSONDecode(reqmod)

local targetFolder = Instance.new("Folder")
targetFolder.Name = "Airplain"
targetFolder.Parent = game.Workspace
local modfolder = Instance.new("Folder")
modfolder.Name = "DesignModules"
modfolder.Parent = targetFolder

for i = 1, #jsonmain do
	local file = jsonmain[i]
	if (file.type == "file") then
		local name = file.name:sub(1, #file.name-4)
		local main = targetFolder:FindFirstChild(name) or Instance.new("LocalScript")
		main.Name = name
		main.Source = http:GetAsync(file.download_url)
		main.Parent = targetFolder
		
	end
end
for i = 1, #jsonmod do
	local file = jsonmod[i]
	if (file.type == "file") then
		local name = file.name:sub(1, #file.name-4)
		local main = targetFolder:FindFirstChild(name) or Instance.new("ModuleScript")
		main.Name = name
		main.Source = http:GetAsync(file.download_url)
		main.Parent = modfolder
		
	end
end
```

# License
License is under the MIT License. See [LICENSE](LICENSE) for more details
