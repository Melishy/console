-- open source ofc, because it's like easy to make your own one.

if not game.GameId == "126922689754590" then return end
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

--[[ VARIABLES ]]--

local Players = game:GetService("Players")
local speaker = Players.LocalPlayer
local mouse = speaker:GetMouse()

local connection
local yello = false
local pusheyo = false
local vcing = false
local scanno = false

function isVoicePlace() 
    return game.PlaceId ~= "81399969866087" 
end

--[[ WINDOW ]]--

local MargoConsole = WindUI:CreateWindow({
	Title = "Margo Console",
	Icon = "fish",
	Author = "by melishy",
	Size = UDim2.fromOffset(530, 470),
    Transparent = true,
})

MargoConsole:DisableTopbarButtons({
    "Fullscreen",
})

MargoConsole:EditOpenButton({
    Title = "Margo Console",
    CornerRadius = UDim.new(0, 20),
    StrokeThickness = 0,
    OnlyMobile = true,
    Enabled = true,
    Draggable = true,
});

MargoConsole:SetToggleKey(Enum.KeyCode.V)

MargoConsole:Tag({
    Title = "Quiet or Die",
    Color = Color3.fromRGB(232, 187, 102)
})

--[[ TABS ]]--

local Main = MargoConsole:Tab({
	Title = "Main",
	Icon = "book-dashed",
})

local Survivor = MargoConsole:Tab({
	Title = "Survivor",
	Icon = "infinity",
})

local Killer = MargoConsole:Tab({
	Title = "Killer",
	Icon = "slice",
})

local Gamepass = MargoConsole:Tab({
	Title = "Gamepass",
	Icon = "bubbles",
})

local Binds = MargoConsole:Tab({
	Title = "Binds",
	Icon = "keyboard",
})

--[[ MAIN TAB (SELECTED) ]]--

Main:Select()

Main:Toggle({
	Title = "Toggle Teleport Tool",
	Desc = "Gives you Teleport Tool, even if you respawned",
	Type = "Toggle",
	Default = false,
	Callback = function(state)
		local function gib()
			local tool = Instance.new("Tool")
			tool.Name = "Teleport Tool"
			tool.RequiresHandle = false
			tool.Parent = speaker.Backpack

			tool.Activated:Connect(function()
				local Char = speaker.Character or workspace:FindFirstChild(speaker.Name)
				local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
				if not Char or not HRP then
					return warn("Failed to find HumanoidRootPart")
				end

				HRP.CFrame = CFrame.new(mouse.Hit.X, mouse.Hit.Y + 3, mouse.Hit.Z, select(4, HRP.CFrame:components()))
			end)
			
			return tool
		end

		if state then
			if not speaker.Backpack:FindFirstChild("Teleport Tool") then
				gib()
			end

			connection = speaker.CharacterAdded:Connect(function()
				gib()
			end)
		else
			if connection then
				connection:Disconnect()
				connection = nil
				
				local tool = speaker.Backpack:FindFirstChild("Teleport Tool")
				if tool then tool:Destroy() end
			end
		end
	end
})

Main:Divider()

Main:Keybind({
	Title = "Bind to toggle this GUI",
    Desc = "You can change it anytime",
    Value = "V",
    Callback = function(bind)
        MargoConsole:SetToggleKey(Enum.KeyCode[bind])
    end
})

--[[ SURVIVOR TAB ]]--

Survivor:Toggle({
	Title = "Yell Repeatedly",
	Desc = "Cooldown? What's that?",
	Type = "Toggle",
	Default = false,
	Callback = function(state)
		yello = state

		local function yell()
			local args = { 1 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			task.spawn(function()
				repeat
					yell()
					task.wait(.1)
				until not yello
			end)
		end
	end
})

Survivor:Button({
    Title = "One-time Yell",
	Desc = "[for mobile users]",
    Callback = function()
        local args = { 1 }
		game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
    end
})

Survivor:Divider()

Survivor:Toggle({
	Title = "Toggle fake VC activation",
	Desc = "Best method to leak your location!",
	Type = "Toggle",
	Default = false,
    Locked = isVoicePlace(),
	Callback = function(state)
		vcing = state

		local function vcify()
			game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
		end

    	if state then
    		task.spawn(function()
    			repeat
    				vcify()
    				task.wait(.1)
    			until not vcing
    		end)
    	end
    end
})

Survivor:Button({
    Title = "One-time fake VC activation",
	Desc = "[for mobile users]",
    Locked = isVoicePlace(),
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
    end
})

Survivor:Section({
    Title = "Note that it only works in VC servers! Locking that keybind doesn't work yet",
    TextSize = 13,
    Opened = true
})

--[[ KILLER TAB ]]--

Killer:Paragraph({
    Title = "INFO",
    Desc = "It works even if you're not a Killer. That makes so OP",
})

Killer:Divider()

Killer:Toggle({
	Title = "Toggle Scan",
	Desc = "Just like a Killer that can scan everyone's locations",
	Type = "Toggle",
	Default = false,
	Callback = function(state)
		scanno = state

		local function scanify()
			local args = { 3 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			task.spawn(function()
				repeat
					scanify()
					task.wait(.1)
				until not scanno
			end)
		end
	end
})

Killer:Button({
    Title = "One-time Scan",
	Desc = "[for mobile users]",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
    end
})

--[[ GAMEPASSES TAB ]]--

Gamepass:Paragraph({
    Title = "NOTICE",
    Desc = "If you don't have gamepass bought, the game will ask you to buy it!",
})

Gamepass:Divider()

Gamepass:Toggle({
	Title = "Push Repeatedly",
	Desc = "Woah, i guess you mastered your boxing skills...",
	Type = "Toggle",
	Default = false,
	Callback = function(state)
		pusheyo = state

		local function push()
			local args = { 2 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			task.spawn(function()
				repeat
					push()
					task.wait(.1)
				until not pusheyo
			end)
		end
	end
})

Gamepass:Button({
    Title = "One-time Push",
    Desc = "[for mobile users] Please note that you must own \"Push Players\" gamepass!",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
    end
})

Gamepass:Divider()

Gamepass:Toggle({
	Title = "Set Trap Repeatedly",
	Desc = "Be warned that it might crash the server, but not tested!",
	Type = "Toggle",
	Default = false,
	Callback = function(state)
		trapeyo = state

		local function trap()
			local args = { 4 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			task.spawn(function()
				repeat
					push()
					task.wait(.1)
				until not trapeyo
			end)
		end
	end
})

Gamepass:Button({
    Title = "One-time Set Trap",
    Desc = "[for mobile users] Please note that you must own \"Killer's Trap\" gamepass!",
    Callback = function()
        local args = { 3 }
		game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
    end
})

--[[ BINDS TAB ]]--

Binds:Keybind({
	Title = "One-time Yell",
	Desc = "I don't know what's cooldown yet...",
	Value = "Q",
	Callback = function()
		local args = { 1 }
		game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
	end
})

Binds:Keybind({
	Title = "One-time fake VC activation",
    Desc = "Seems like indeed the best location leaker",
    Value = "R",
    --Locked = isVoicePlace(),
    Callback = function()
        if isVoicePlace() then
    	    game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
        end
    end
})

Binds:Section({
    Title = "Note that it only works in VC servers! Locking that keybind doesn't work yet",
    TextSize = 13,
    Opened = true
})

Binds:Divider()

Binds:Keybind({
	Title = "One-time Scan",
    Desc = "Yeah... Why's the game so vulnerable?",
    Value = "Z",
    Callback = function()
        local args = { 3 }
        game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
    end
})

Binds:Divider()

Binds:Keybind({
	Title = "One-time Set Trap",
	Desc = "Please note that you must own \"Killer's Trap\" gamepass!",
	Value = "X",
	Callback = function()
		local args = { 4 }
		game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
	end
})

Binds:Keybind({
	Title = "One-time Push",
	Desc = "Please note that you must own \"Push Players\" gamepass!",
	Value = "C",
	Callback = function()
		local args = { 2 }
		game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
	end
})
