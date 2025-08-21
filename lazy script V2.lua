local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "lazy hub V2",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "just a lazy hub",
    LoadingSubtitle = "by ivan(lazy)",
    ShowText = "LAZY", -- for mobile users to unhide rayfield, change if you'd like
    Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "lazy hub"
    },
 
    Discord = {
       Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "ruybjJVWqv", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "lazy hub",
       Subtitle = "Key System",
       Note = "key in the discord", -- Use this to tell the user how to get a key
       FileName = "lazy hub", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"https://pastebin.com/raw/EL7Xic6s"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 Rayfield:Notify({
    Title = "lazy hub",
    Content = "loaded",
    Duration = 6.5,
    Image = 1407533562860797952,
 })

 local MainTab = Window:CreateTab("Home😎", 4483362458) -- Title, Image

 local MainSection = MainTab:CreateSection("Main")

 local Slider = MainTab:CreateSlider({
   Name = "walkspeed",
   Range = {16, 1000},
   Increment = 1,
   Suffix = "walkspeed",
   CurrentValue = 16,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

local Slider = MainTab:CreateSlider({
	Name = "jumppower",
	Range = {50, 1000},
	Increment = 10,
	Suffix = "JumpPower",
	CurrentValue = 50,
	Flag = "Slider1",
	Callback = function(Value)
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.UseJumpPower = true
			humanoid.JumpPower = Value
		end
	end,
})

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

-- 用來儲存連線，切換 OFF 時可解除
local antiAfkConn

local Toggle = MainTab:CreateToggle({
	Name = "Anti-AFK",
	CurrentValue = false,
	Flag = "ToggleAntiAFK",
	Callback = function(enabled)
		if enabled then
			-- 確保不會重複註冊
			if antiAfkConn then
				antiAfkConn:Disconnect()
				antiAfkConn = nil
			end

			antiAfkConn = player.Idled:Connect(function()
				-- 模擬滑鼠右鍵按下/放開，防 AFK 踢出
				VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				task.wait(1)
				VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)
		else
			-- 關閉 Anti-AFK
			if antiAfkConn then
				antiAfkConn:Disconnect()
				antiAfkConn = nil
			end
		end
	end,
})

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local controls = require(player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()

local freecamOn = false
local saved = {}
local conn = {}
local loopConn

local camPos
local yaw, pitch

local keyDown = {W=false,A=false,S=false,D=false,Q=false,E=false,Shift=false}
local baseSpeed = 32 -- studs/sec
local fastMult = 3
local mouseSensitivity = 0.002

local function bindInputs()
	conn[#conn+1] = UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.W then keyDown.W = true
		elseif input.KeyCode == Enum.KeyCode.A then keyDown.A = true
		elseif input.KeyCode == Enum.KeyCode.S then keyDown.S = true
		elseif input.KeyCode == Enum.KeyCode.D then keyDown.D = true
		elseif input.KeyCode == Enum.KeyCode.Q then keyDown.Q = true
		elseif input.KeyCode == Enum.KeyCode.E then keyDown.E = true
		elseif input.KeyCode == Enum.KeyCode.LeftShift then keyDown.Shift = true
		end
	end)

	conn[#conn+1] = UIS.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.W then keyDown.W = false
		elseif input.KeyCode == Enum.KeyCode.A then keyDown.A = false
		elseif input.KeyCode == Enum.KeyCode.S then keyDown.S = false
		elseif input.KeyCode == Enum.KeyCode.D then keyDown.D = false
		elseif input.KeyCode == Enum.KeyCode.Q then keyDown.Q = false
		elseif input.KeyCode == Enum.KeyCode.E then keyDown.E = false
		elseif input.KeyCode == Enum.KeyCode.LeftShift then keyDown.Shift = false
		end
	end)

	conn[#conn+1] = UIS.InputChanged:Connect(function(input, gpe)
		if gpe then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			local d = input.Delta
			yaw -= d.X * mouseSensitivity
			pitch = math.clamp(pitch - d.Y * mouseSensitivity, -1.4, 1.4)
		end
	end)
end

local function unbindInputs()
	for _,c in ipairs(conn) do c:Disconnect() end
	table.clear(conn)
end

local function enableFreecam()
	if freecamOn then return end
	freecamOn = true

	saved.camType = camera.CameraType
	saved.camSubject = camera.CameraSubject
	saved.mouseBehavior = UIS.MouseBehavior
	saved.mouseIcon = UIS.MouseIconEnabled

	controls:Disable() -- 角色不會跟著移動
	camera.CameraType = Enum.CameraType.Scriptable
	UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
	UIS.MouseIconEnabled = false

	local x,y,z = camera.CFrame:ToEulerAnglesYXZ()
	pitch, yaw = x, y
	camPos = camera.CFrame.Position

	bindInputs()

	loopConn = RunService.RenderStepped:Connect(function(dt)
		local rot = CFrame.fromEulerAnglesYXZ(pitch, yaw, 0)
		local forward = rot.LookVector
		local right = rot.RightVector
		local up = Vector3.yAxis

		local move = Vector3.zero
		if keyDown.W then move += forward end
		if keyDown.S then move -= forward end
		if keyDown.D then move += right end
		if keyDown.A then move -= right end
		if keyDown.E then move += up end
		if keyDown.Q then move -= up end

		local speed = baseSpeed * (keyDown.Shift and fastMult or 1)
		if move.Magnitude > 0 then
			camPos += move.Unit * speed * dt
		end

		camera.CFrame = CFrame.new(camPos) * rot
	end)
end

local function disableFreecam()
	if not freecamOn then return end
	freecamOn = false

	if loopConn then loopConn:Disconnect() loopConn = nil end
	unbindInputs()

	UIS.MouseBehavior = saved.mouseBehavior or Enum.MouseBehavior.Default
	UIS.MouseIconEnabled = saved.mouseIcon ~= false
	camera.CameraType = saved.camType or Enum.CameraType.Custom
	camera.CameraSubject = saved.camSubject

	controls:Enable()
end

-- 你的 Toggle
local Toggle = MainTab:CreateToggle({
	Name = "Freecam",
	CurrentValue = false,
	Flag = "ToggleFreecam",
	Callback = function(on)
		if on then
			enableFreecam()
		else
			disableFreecam()
		end
	end,
})

-- 放在同一個 LocalScript（與 UI 一起）
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local flyOn = false
local flyLoop
local inputConns = {}
local bg, bv
local speed = 60
local fastMult, slowMult = 2, 0.5
local keys = {W=false,A=false,S=false,D=false,Q=false,E=false,Shift=false,Ctrl=false}
local saved = {}

local function bindInputs()
	inputConns[#inputConns+1] = UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		local kc = input.KeyCode
		if kc == Enum.KeyCode.W then keys.W = true
		elseif kc == Enum.KeyCode.A then keys.A = true
		elseif kc == Enum.KeyCode.S then keys.S = true
		elseif kc == Enum.KeyCode.D then keys.D = true
		elseif kc == Enum.KeyCode.E then keys.E = true
		elseif kc == Enum.KeyCode.Q then keys.Q = true
		elseif kc == Enum.KeyCode.LeftShift then keys.Shift = true
		elseif kc == Enum.KeyCode.LeftControl then keys.Ctrl = true
		end
	end)
	inputConns[#inputConns+1] = UIS.InputEnded:Connect(function(input)
		local kc = input.KeyCode
		if kc == Enum.KeyCode.W then keys.W = false
		elseif kc == Enum.KeyCode.A then keys.A = false
		elseif kc == Enum.KeyCode.S then keys.S = false
		elseif kc == Enum.KeyCode.D then keys.D = false
		elseif kc == Enum.KeyCode.E then keys.E = false
		elseif kc == Enum.KeyCode.Q then keys.Q = false
		elseif kc == Enum.KeyCode.LeftShift then keys.Shift = false
		elseif kc == Enum.KeyCode.LeftControl then keys.Ctrl = false
		end
	end)
end

local function unbindInputs()
	for _,c in ipairs(inputConns) do c:Disconnect() end
	table.clear(inputConns)
end

local function startFly()
	if flyOn then return end
	flyOn = true

	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	local humanoid = char:WaitForChild("Humanoid")

	saved.platformStand = humanoid.PlatformStand
	humanoid.PlatformStand = true

	bg = Instance.new("BodyGyro")
	bg.P = 9e4
	bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bg.CFrame = workspace.CurrentCamera.CFrame
	bg.Parent = hrp

	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bv.Velocity = Vector3.zero
	bv.Parent = hrp

	bindInputs()

	flyLoop = RunService.RenderStepped:Connect(function(dt)
		if not hrp or not hrp.Parent then return end

		local cam = workspace.CurrentCamera
		bg.CFrame = cam.CFrame

		local look = cam.CFrame.LookVector
		local right = cam.CFrame.RightVector

		local horizForward = Vector3.new(look.X, 0, look.Z)
		local horizRight = Vector3.new(right.X, 0, right.Z)

		local move = Vector3.zero
		if keys.W then move += horizForward end
		if keys.S then move -= horizForward end
		if keys.D then move += horizRight end
		if keys.A then move -= horizRight end

		local vertical = 0
		if keys.E then vertical += 1 end
		if keys.Q then vertical -= 1 end

		local currentSpeed = speed * (keys.Shift and fastMult or 1) * (keys.Ctrl and slowMult or 1)
		local vel = Vector3.zero
		if move.Magnitude > 0 then
			vel += move.Unit * currentSpeed
		end
		if vertical ~= 0 then
			vel += Vector3.new(0, currentSpeed * vertical, 0)
		end

		bv.Velocity = vel
	end)
end

local function stopFly()
	if not flyOn then return end
	flyOn = false

	if flyLoop then flyLoop:Disconnect() flyLoop = nil end
	unbindInputs()

	if bg then bg:Destroy() bg = nil end
	if bv then bv:Destroy() bv = nil end

	local char = player.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then hum.PlatformStand = saved.platformStand == true end
	end

	keys = {W=false,A=false,S=false,D=false,Q=false,E=false,Shift=false,Ctrl=false}
end

player.CharacterAdded:Connect(function()
	if flyOn then
		stopFly()
		startFly()
	end
end)

-- 你的 Toggle
local Toggle = MainTab:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Flag = "ToggleFly",
	Callback = function(enabled)
		if enabled then
			startFly()
		else
			stopFly()
		end
	end,
})

-- 放在與 UI 同一個 LocalScript
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local noclipEnabled = false
local noclipConn
local changedParts = {} -- 記錄被我們改成 false 的部件，關閉時恢復

local function applyNoclipToCharacter(character)
	for _, obj in ipairs(character:GetDescendants()) do
		if obj:IsA("BasePart") and obj.CanCollide == true then
			obj.CanCollide = false
			changedParts[obj] = true
		end
	end
end

local function startNoclip()
	if noclipEnabled then return end
	noclipEnabled = true
	table.clear(changedParts)

	local character = player.Character or player.CharacterAdded:Wait()

	-- 在物理步前持續確保部件不碰撞
	noclipConn = RunService.Stepped:Connect(function()
		if not character or not character.Parent then
			character = player.Character
			return
		end
		applyNoclipToCharacter(character)
	end)
end

local function stopNoclip()
	if not noclipEnabled then return end
	noclipEnabled = false

	if noclipConn then noclipConn:Disconnect() noclipConn = nil end

	-- 將被我們改過的部件恢復為可碰撞
	for part in pairs(changedParts) do
		if part and part.Parent then
			part.CanCollide = true
		end
	end
	table.clear(changedParts)
end

-- 重生時若仍開啟，重新套用
Players.LocalPlayer.CharacterAdded:Connect(function()
	if noclipEnabled then
		if noclipConn then noclipConn:Disconnect() end
		table.clear(changedParts)
		startNoclip()
	end
end)

-- 你的 Toggle
local Toggle = MainTab:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "ToggleNoclip",
	Callback = function(enabled)
		if enabled then
			startNoclip()
		else
			stopNoclip()
		end
	end,
})

local Button = MainTab:CreateButton({
   Name = "tp tool",
   Callback = function()
      mouse = game.Players.LocalPlayer:GetMouse()
      tool = Instance.new("Tool")
      tool.RequiresHandle = false
      tool.Name = "lazy's tp tool"
      tool.Activated:connect(function()
      local pos = mouse.Hit+Vector3.new(0,2.5,0)
      pos = CFrame.new(pos.X,pos.Y,pos.Z)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
      end)
      tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})

-- 放在同一個 LocalScript 上方（Button 之前）
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function applyInfZoom()
	player.CameraMode = Enum.CameraMode.Classic -- 確保允許滾輪縮放
	player.CameraMinZoomDistance = 0
	player.CameraMaxZoomDistance = 1e10
end

local infZoomConn -- 避免重複註冊

local Button = MainTab:CreateButton({
   Name = "Infinite Zoom",
   Callback = function()
      if infZoomConn then infZoomConn:Disconnect() end
      applyInfZoom()
      infZoomConn = RunService.RenderStepped:Connect(function()
         applyInfZoom()
      end)
   end,
})

local ESPTab = Window:CreateTab("ESP", nil) -- Title, Image
local Section = ESPTab:CreateSection("ESP")

local espColor = Color3.fromRGB(255, 80, 80)
local showNames = false

local localPlayer = Players.LocalPlayer
local espEnabled = false
local loopConn
local playerAddedConn
local playerRemovingConn
local charAddedConns = {}
local highlights = {}
local billboards = {}

local function removeEspForPlayer(plr)
	if highlights[plr] then highlights[plr]:Destroy() highlights[plr] = nil end
	if billboards[plr] then billboards[plr]:Destroy() billboards[plr] = nil end
	if charAddedConns[plr] then charAddedConns[plr]:Disconnect() charAddedConns[plr] = nil end
end

local function applyEspColorTo(plr)
	local h = highlights[plr]
	if h then h.OutlineColor = espColor end
	local bb = billboards[plr]
	if bb then
		local label = bb:FindFirstChildOfClass("TextLabel")
		if label then label.TextColor3 = espColor end
	end
end

local function applyEspColorAll()
	for plr in pairs(highlights) do
		applyEspColorTo(plr)
	end
end

-- 單一版本（移除你原來巢狀/重複的 createEspForCharacter）
local function createEspForCharacter(plr, character)
	if plr == localPlayer then return end
	removeEspForPlayer(plr)

	local highlight = Instance.new("Highlight")
	highlight.Name = "ESP_Highlight"
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0
	highlight.OutlineColor = espColor
	highlight.Adornee = character
	highlight.Parent = character
	highlights[plr] = highlight

	local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 3)
	if head then
		local bb = Instance.new("BillboardGui")
		bb.Name = "ESP_Billboard"
		bb.Adornee = head
		bb.Size = UDim2.fromOffset(200, 32)
		bb.StudsOffset = Vector3.new(0, 2.5, 0)
		bb.AlwaysOnTop = true
		bb.MaxDistance = 5000
		bb.Enabled = showNames
		bb.Parent = head

		local text = Instance.new("TextLabel")
		text.BackgroundTransparency = 1
		text.Size = UDim2.fromScale(1, 1)
		text.TextColor3 = espColor
		text.TextStrokeTransparency = 0.5
		text.Font = Enum.Font.SourceSansBold
		text.TextScaled = true
		text.Text = plr.DisplayName
		text.Parent = bb

		billboards[plr] = bb
	end
end

local function hookPlayer(plr)
	if plr == localPlayer then return end
	if plr.Character then
		createEspForCharacter(plr, plr.Character)
	end
	charAddedConns[plr] = plr.CharacterAdded:Connect(function(char)
		createEspForCharacter(plr, char)
	end)
end

local function enableEsp()
	if espEnabled then return end
	espEnabled = true

	for _, plr in ipairs(Players:GetPlayers()) do
		hookPlayer(plr)
	end
	playerAddedConn = Players.PlayerAdded:Connect(hookPlayer)
	playerRemovingConn = Players.PlayerRemoving:Connect(removeEspForPlayer)

	loopConn = RunService.Heartbeat:Connect(function()
		local myChar = localPlayer.Character
		local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
		if not myHRP then return end
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= localPlayer then
				local bb = billboards[plr]
				local char = plr.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if bb and hrp then
					local dist = (hrp.Position - myHRP.Position).Magnitude
					local label = bb:FindFirstChildOfClass("TextLabel")
					if label then
						label.Text = string.format("%s  [%.0f]", plr.DisplayName, dist)
					end
				end      
			end
		end
	end)

	-- 在建立完與掛鉤後，統一套一次當前顏色
	applyEspColorAll()
end

local function disableEsp()
	if not espEnabled then return end
	espEnabled = false

	if loopConn then loopConn:Disconnect() loopConn = nil end
	if playerAddedConn then playerAddedConn:Disconnect() playerAddedConn = nil end
	if playerRemovingConn then playerRemovingConn:Disconnect() playerRemovingConn = nil end

	-- 只跑一次清理即可
	for plr in pairs(highlights) do removeEspForPlayer(plr) end
end

-- 你的 Toggle
local Toggle = ESPTab:CreateToggle({
	Name = "ESP",
	CurrentValue = false,
	Flag = "ToggleESP",
	Callback = function(on)
		if on then
			enableEsp()
			applyEspColorAll()
		else
			disableEsp()
			applyEspColorAll()
		end
	end,
})

local espColor = Color3.fromRGB(255, 80, 80)

local function applyEspColorTo(plr)
	local h = highlights[plr]
	if h then
		h.OutlineColor = espColor
	end
	local bb = billboards[plr]
	if bb then
		local label = bb:FindFirstChildOfClass("TextLabel")
		if label then
			label.TextColor3 = espColor
		end
	end
end

-- 套色到所有現存 ESP
local function applyEspColorAll()
	for plr,_ in pairs(highlights) do
		applyEspColorTo(plr)
	end
end

-- 在你原本的 createEspForCharacter 裡，將顏色綁定為 espColor
-- 例：
-- highlight.OutlineColor = espColor
-- text.TextColor3 = espColor

-- 建立 ColorPicker（與你的 UI 同個 Tab）
local ColorPicker = ESPTab:CreateColorPicker({
	Name = "ESP Color",
	Color = espColor,
	Flag = "ColorPickerESP",
	Callback = function(Value)
		espColor = Value
		applyEspColorAll()
	end
})

local ToggleShowNames = ESPTab:CreateToggle({
	Name = "Show Names",
	CurrentValue = showNames,
	Flag = "ToggleESPShowNames",
	Callback = function(val)
		showNames = val
		for _, bb in pairs(billboards) do
			if bb and bb.Parent then
				bb.Enabled = showNames
			end
		end
	end,
})
