# Airplain 
Airplain is a Full Suite of Project Management Tools for Roblox Studio. It is in the form of a plugin.

# Bringing the project into studio
The easiest way to bring the project into studio is to use the HttpService to pull the contents directly from this github project into module scripts. After enabling the http service from Game Settings the following code can be run in the command bar.
```lua
local http = game:GetService("HttpService")
local req = http:GetAsync("https://api.github.com/repos/CJAstra/airplain/contents/src")
local json = http:JSONDecode(req)

local targetFolder = Instance.new("Folder")
targetFolder.Name = "Airplain"
targetFolder.Parent = game.Workspace

for i = 1, #json do
	local file = json[i]
	if (file.type == "file") then
		local name = file.name:sub(1, #file.name-4)
		local module = targetFolder:FindFirstChild(name) or Instance.new("ModuleScript")
		module.Name = name
		module.Source = http:GetAsync(file.download_url)
		module.Parent = targetFolder
	end
end
```

# License
License is under the MIT License. See [LICENSE](LICENSE) for more details
