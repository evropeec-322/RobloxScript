--[[

Open source
Made by Evropeec 
Credits to me

Credits to the Owner Who Made The Hitbox Script

]]

local CoreGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

local function isNumber(str)
    return tonumber(str) ~= nil or str == "inf"
end

--// Global Settings
getgenv().HitboxSize = 15
getgenv().HitboxTransparency = 0.9
getgenv().HitboxStatus = false
getgenv().TeamCheck = false
getgenv().Walkspeed = Humanoid and Humanoid.WalkSpeed or 16
getgenv().Jumppower = Humanoid and Humanoid.JumpPower or 50
getgenv().TPSpeed = 3
getgenv().TPWalk = false

--// UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/UI-Library/main/Source/MyUILib(Unamed).lua"))()
local Window = Library:Create("Hitbox Expander")

--// Toggle UI Button
local ToggleGui = Instance.new("ScreenGui")
local Toggle = Instance.new("TextButton")

ToggleGui.Name = "ToggleGui_HE"
ToggleGui.Parent = game.CoreGui

Toggle.Name = "Toggle"
Toggle.Parent = ToggleGui
Toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Toggle.BackgroundTransparency = 0.66
Toggle.Position = UDim2.new(0, 0, 0.45, 0)
Toggle.Size = UDim2.new(0.065, 0, 0.088, 0)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = "Toggle"
Toggle.TextScaled = true
Toggle.TextColor3 = Color3.fromRGB(40, 40, 40)
Toggle.Active = true
Toggle.Draggable = true
Toggle.MouseButton1Click:Connect(function()
    Library:ToggleUI()
end)

--// Functions
local function updateHitbox()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if getgenv().HitboxStatus and (not getgenv().TeamCheck or player.Team ~= LocalPlayer.Team) then
                hrp.Size = Vector3.new(getgenv().HitboxSize, getgenv().HitboxSize, getgenv().HitboxSize)
                hrp.Transparency = getgenv().HitboxTransparency
                hrp.BrickColor = BrickColor.new("Really black")
                hrp.Material = Enum.Material.Neon
                hrp.CanCollide = false
            else
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
                hrp.BrickColor = BrickColor.new("Medium stone grey")
                hrp.Material = Enum.Material.Plastic
                hrp.CanCollide = false
            end
        end
    end
end

RunService.RenderStepped:Connect(updateHitbox)

--// UI Elements
local HomeTab = Window:Tab("Home", "rbxassetid://10888331510")
local PlayerTab = Window:Tab("Players", "rbxassetid://12296135476")

HomeTab:Toggle("Hitbox Status", function(state)
    getgenv().HitboxStatus = state
end)

HomeTab:Toggle("Team Check", function(state)
    getgenv().TeamCheck = state
end)

HomeTab:TextBox("Hitbox Size", function(value)
    getgenv().HitboxSize = tonumber(value) or 15
end)

HomeTab:TextBox("Hitbox Transparency", function(value)
    getgenv().HitboxTransparency = tonumber(value) or 0.9
end)

PlayerTab:TextBox("WalkSpeed", function(value)
    getgenv().Walkspeed = tonumber(value) or 16
    if Humanoid then
        Humanoid.WalkSpeed = getgenv().Walkspeed
    end
end)

PlayerTab:Toggle("Loop WalkSpeed", function(state)
    getgenv().loopW = state
    RunService.Heartbeat:Connect(function()
        if getgenv().loopW and Humanoid then
            Humanoid.WalkSpeed = getgenv().Walkspeed
        end
    end)
end)

PlayerTab:TextBox("JumpPower", function(value)
    getgenv().Jumppower = tonumber(value) or 50
    if Humanoid then
        Humanoid.JumpPower = getgenv().Jumppower
    end
end)

PlayerTab:Toggle("Loop JumpPower", function(state)
    getgenv().loopJ = state
    RunService.Heartbeat:Connect(function()
        if getgenv().loopJ and Humanoid then
            Humanoid.JumpPower = getgenv().Jumppower
        end
    end)
end)

PlayerTab:Toggle("Infinite Jump", function(state)
    getgenv().InfJ = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if getgenv().InfJ and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

PlayerTab:Button("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

print("Optimized script loaded!") 
