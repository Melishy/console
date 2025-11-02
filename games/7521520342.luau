-- open source ofc, because it's like easy to make your own one.

if not game.GameId == 7521520342 then return end
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

--[[ VARIABLES ]]--

local Players = game:GetService("Players")
local Speaker = Players.LocalPlayer
local Mouse = Speaker:GetMouse()
local RunService = game:GetService("RunService")

local tpCon, yellCon, vcCon, scanCon, pushCon, trapCon
local Yello, Pusheyo, VCing, Scanno, Trapeyo = false, false, false, false, false

function isNormalPlace() 
    return game.PlaceId ~= 81399969866087
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
			tool.Parent = Speaker.Backpack

			tool.Activated:Connect(function()
				local Char = Speaker.Character or workspace:FindFirstChild(Speaker.Name)
				local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
				if not Char or not HRP then
					return warn("Failed to find HumanoidRootPart")
				end

				HRP.CFrame = CFrame.new(Mouse.Hit.X, Mouse.Hit.Y + 3, Mouse.Hit.Z, select(4, HRP.CFrame:components()))
			end)
			
			return tool
		end

		if state then
			if not Speaker.Backpack:FindFirstChild("Teleport Tool") then
				gib()
			end

			tpCon = Speaker.CharacterAdded:Connect(function()
				gib()
			end)
		else
			if tpCon then
				tpCon:Disconnect()
				tpCon = nil
				
				local tool = Speaker.Backpack:FindFirstChild("Teleport Tool")
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
		Yello = state

		local function yell()
			local args = { 1 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			yellCon = RunService.Heartbeat:Connect(yell)
		else
			if yellCon then
				yellCon:Disconnect()
				yellCon = nil
			end
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
    Locked = isNormalPlace(),
	Callback = function(state)
		VCing = state

		local function vcify()
			game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
		end

    	if state then
    		vcCon = RunService.Heartbeat:Connect(vcify)
    	else
			if vcCon then
				vcCon:Disconnect()
				vcCon = nil
			end
    	end
    end
})

Survivor:Button({
    Title = "One-time fake VC activation",
	Desc = "[for mobile users]",
    Locked = isNormalPlace(),
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
    end
})

--[[ KILLER TAB ]]--

Killer:Paragraph({
    Title = "INFO",
    Desc = "It works even if you're not a Killer. That makes so OP",
})

Killer:Divider()

Killer:Toggle({
	Title = "Toggle Radar",
	Desc = "Just like a Killer that can scan everyone's locations [OP: DISABLES REVIVING FOR EVERYONE]",
	Type = "Toggle",
	Default = false,
	Callback = function(state)
		Scanno = state

		local function scanify()
			local args = { 3 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			scanCon = RunService.Heartbeat:Connect(scanify)
		else
			if scanCon then
				scanCon:Disconnect()
				scanCon = nil
			end
		end
	end
})

Killer:Button({
    Title = "One-time Scan",
	Desc = "[for mobile users]",
    Callback = function()
        local args = { 3 }
        game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
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
		Pusheyo = state

		local function push()
			local args = { 2 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			pushCon = RunService.Heartbeat:Connect(push)
		else
			if pushCon then
				pushCon:Disconnect()
				pushCon = nil
			end
		end
	end
})

Gamepass:Button({
    Title = "One-time Push",
    Desc = "[for mobile users] Please note that you must own \"Push Players\" gamepass!",
    Callback = function()
        local args = { 2 }
		game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
    end
})

Gamepass:Divider()

Gamepass:Toggle({
	Title = "Set Trap Repeatedly",
	Desc = "Be warned that it might crash the server, but not tested!",
	Type = "Toggle",
	Default = false,
	Callback = function(state)
		Trapeyo = state

		local function trap()
			local args = { 4 }
			game:GetService("ReplicatedStorage"):WaitForChild("AbilityEvent"):FireServer(unpack(args))
		end

		if state then
			trapCon = RunService.Heartbeat:Connect(trap)
		else
			if trapCon then
				trapCon:Disconnect()
				trapCon = nil
			end
		end
	end
})

Gamepass:Button({
    Title = "One-time Set Trap",
    Desc = "[for mobile users] Please note that you must own \"Killer's Trap\" gamepass!",
    Callback = function()
        local args = { 4 }
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
    Locked = isNormalPlace(),
    Callback = function()
        if isNormalPlace() == false then
    	    game:GetService("ReplicatedStorage"):WaitForChild("VCactivated"):FireServer()
        end
    end
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
