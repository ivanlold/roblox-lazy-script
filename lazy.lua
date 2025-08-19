local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "JustLazyHub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "LazyHub",
   LoadingSubtitle = "by Lazy",
   ShowText = "LazyHub", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "w5KaTqKgbw", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Lazy Key System",
      Subtitle = "Key in discord",
      Note = "Discord pls add", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/EL7Xic6s"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

Rayfield:Notify({
   Title = "LazyHub executed",
   Content = "nice lilbro",
   Duration = 5,
   Image = nil,
})

local HomeTab = Window:CreateTab("👍home", nil) -- Title, Image
local Section = HomeTab:CreateSection("Main") -- Title

local Button = HomeTab:CreateButton({
   Name = "TP tool",
   Callback = function()
   mouse = game.Players.LocalPlayer:GetMouse()
   tool = Instance.new("Tool")
   tool.RequiresHandle = false
   tool.Name = "tp Tool"
   tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})  

local Slider = HomeTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "JustLazyHub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "LazyHub",
   LoadingSubtitle = "by Lazy",
   ShowText = "LazyHub", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "8eeWZ85mYV", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Lazy Key System",
      Subtitle = "Key in discord",
      Note = "Discord pls add", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/EL7Xic6s"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

Rayfield:Notify({
   Title = "LazyHub executed",
   Content = "nice lilbro",
   Duration = 5,
   Image = nil,
})

local HomeTab = Window:CreateTab("👍home", nil) -- Title, Image
local Section = HomeTab:CreateSection("Main") -- Title

local Button = HomeTab:CreateButton({
   Name = "TP tool",
   Callback = function()
   mouse = game.Players.LocalPlayer:GetMouse()
   tool = Instance.new("Tool")
   tool.RequiresHandle = false
   tool.Name = "tp Tool"
   tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})  

local Input = HomeTab:CreateInput({
   Name = "WalkSpeed",
   CurrentValue = "16",
   PlaceholderText = "1-300",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
   game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (value   or tonumber(Text) or 16)
   end,
})

local Input = HomeTab:CreateInput({
   Name = "Jump power",
   CurrentValue = "20",
   PlaceholderText = "1-300",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
   game.Players.LocalPlayer.Character.Humanoid.JumpPower = (tonumber(Text) or 20)
   end,
})

local Button = HomeTab:CreateButton({
   Name = "Noclip  (Press E to toggle)",
   Callback = function()
   local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local mouse = plr:GetMouse()
local noclip = false

mouse.KeyDown:Connect(function(key)
    if key == "e" then  -- 按 E 鍵切換 Noclip
        noclip = not noclip
        if noclip then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Noclip",
                Text = "on",
                Duration = 2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Noclip",
                Text = "off",
                Duration = 2
            })
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 當角色重生時重新連接
plr.CharacterAdded:Connect(function(newChar)
    char = newChar
end)
   end,
})

local Button = HomeTab:CreateButton({
   Name = "fly (Press F to toggle)",
   Callback = function()
    local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local char = plr.Character or plr.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local flying = false
local speed = 50 -- 預設飛行速度
local minSpeed = 10 -- 最低速度
local maxSpeed = 200 -- 最高速度
local speedIncrement = 10 -- 每次調整的速度增量

-- 顯示當前速度
local function showSpeedNotification()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "flying speed",
        Text = "now speed: " .. speed,
        Duration = 1
    })
end

-- 調整速度
local function adjustSpeed(increase)
    if increase then
        speed = math.min(speed + speedIncrement, maxSpeed)
    else
        speed = math.max(speed - speedIncrement, minSpeed)
    end
    showSpeedNotification()
end

-- 飛行功能
local function toggleFly()
    flying = not flying
    
    if flying then
        local bodyVelocity = Instance.new("BodyVelocity", hrp)
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        local bodyGyro = Instance.new("BodyGyro", hrp)
        bodyGyro.Name = "FlyGyro"
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.P = 9000
        bodyGyro.D = 100
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "flying mode",
            Text = "on (F to toggle L to decrease/P to increase)",
            Duration = 3
        })
        
        spawn(function()
            while flying and hrp and humanoid do
                local newVel = Vector3.new(0, 0, 0)
                
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                    newVel = newVel + (workspace.CurrentCamera.CFrame.LookVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                    newVel = newVel - (workspace.CurrentCamera.CFrame.LookVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                    newVel = newVel - (workspace.CurrentCamera.CFrame.RightVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                    newVel = newVel + (workspace.CurrentCamera.CFrame.RightVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                    newVel = newVel + Vector3.new(0, speed, 0)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                    newVel = newVel - Vector3.new(0, speed, 0)
                end
                
                if hrp:FindFirstChild("FlyVelocity") then
                    hrp.FlyVelocity.Velocity = newVel
                end
                if hrp:FindFirstChild("FlyGyro") then
                    hrp.FlyGyro.CFrame = workspace.CurrentCamera.CFrame
                end
                
                wait()
            end
        end)
    else
        if hrp:FindFirstChild("FlyVelocity") then
            hrp.FlyVelocity:Destroy()
        end
        if hrp:FindFirstChild("FlyGyro") then
            hrp.FlyGyro:Destroy()
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "flying mode",
            Text = "off",
            Duration = 3
        })
    end
end

-- 按鍵控制
mouse.KeyDown:Connect(function(key)
    if key:lower() == "f" then
        toggleFly()
    elseif key:lower() == "p" then -- p 鍵加速
        adjustSpeed(true)
    elseif key:lower() == "l" then -- o 鍵減速
        adjustSpeed(false)
    end
end)

-- 角色重生時重新設置
plr.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
    flying = false
end)
   end,
})

local Button = HomeTab:CreateButton({
   Name = "infinite yield",
   Callback = function()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

local Button = HomeTab:CreateButton({
   Name = "anti-AFK",
   Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/evxncodes/mainroblox/main/anti-afk", true))()
   end,
})

local Toggle = HomeTab:CreateToggle({
   Name = "INF Jump",
   CurrentValue = false,
   Flag = "INFJump", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(infiniteJumpEnabled)
     local infiniteJumpEnabled = true
     game.GetService("UserInputService").JumpRequest:Connect(function()
        if infiniteJumpEnabled then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
     end)
   end,
})


local MiscTab = Window:CreateTab("Misc", nil) -- Title, Image
local Section = MiscTab:CreateSection("discord")

local Button = MiscTab:CreateButton({
   Name = "Discord CopyButton",
   Callback = function()
   setclipboard("https://discord.gg/8eeWZ85mYV")
   end,
})
