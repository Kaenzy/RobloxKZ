-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaenzy/RobloxKZ/refs/heads/main/Bad%20News%20Travels%20Fast%20Script.lua"))()
-- copy the loadstring ↑↑↑↑
-- Idk
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScreenGui = Instance.new("ScreenGui")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
StatusLabel.Parent = ScreenGui
StatusLabel.Size = UDim2.new(0, 200, 0, 70)  -- increased height to show both statuses
StatusLabel.Position = UDim2.new(1, -210, 0, 10)
StatusLabel.BackgroundTransparency = 0.5
StatusLabel.BackgroundColor3 = Color3.new(0, 0, 0)
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.TextScaled = true
StatusLabel.Visible = false

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Bad News Travels Fast script",
    LoadingTitle = "Initializing script",
    LoadingSubtitle = "Please wait...",
    Theme = "Default",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "KZbntf",
        FileName = "bntfsettings"
    },
    Discord = {
        Enabled = false,
        Invite = "yourdiscordinvite",
        RememberJoins = true
    },
    KeySystem = false
})

local TriggerBotTab = Window:CreateTab("Main", "target")

local TriggerBotEnabled = false
local OverlayEnabled = false
local AutoShootEnabled = false

--------------------------------------------------------------------------------
-- Helper function to update the Trigger Bot state and UI label
--------------------------------------------------------------------------------
local function SetTriggerBotState(state)
    TriggerBotEnabled = state
    StatusLabel.Text = ("Trigger Bot: %s\nAuto Shoot: %s"):format(
        (TriggerBotEnabled and "Enabled" or "Disabled"),
        (AutoShootEnabled and "Enabled" or "Disabled")
    )
end

--------------------------------------------------------------------------------
-- Trigger Bot Toggle (UI switch)
--------------------------------------------------------------------------------
local TriggerBotToggle = TriggerBotTab:CreateToggle({
    Name = "Toggle Trigger Bot",
    CurrentValue = false,
    Flag = "TriggerBotToggle",
    Callback = function(Value)
        SetTriggerBotState(Value)
    end,
})

--------------------------------------------------------------------------------
-- Trigger Bot Keybind (toggles on/off)
--------------------------------------------------------------------------------
local TriggerBotKeybind = TriggerBotTab:CreateKeybind({
    Name = "Trigger Bot Keybind",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "TriggerBotKeybind",
    Callback = function()
        local newState = not TriggerBotEnabled
        SetTriggerBotState(newState)
        
        if TriggerBotToggle and TriggerBotToggle.SetState then
            TriggerBotToggle:SetState(newState)
        end
    end,
})

--------------------------------------------------------------------------------
-- Overlay Toggle
--------------------------------------------------------------------------------
local OverlayToggle = TriggerBotTab:CreateToggle({
    Name = "Overlay",
    CurrentValue = false,
    Flag = "OverlayToggle",
    Callback = function(Value)
        OverlayEnabled = Value
        StatusLabel.Visible = OverlayEnabled
    end,
})

--------------------------------------------------------------------------------
-- FOV Slider
--------------------------------------------------------------------------------
local FOVSlider

local function EnforceFOV()
    while true do
        wait()
        if workspace.CurrentCamera.FieldOfView ~= FOVSlider.CurrentValue then
            workspace.CurrentCamera.FieldOfView = FOVSlider.CurrentValue
        end
    end
end

FOVSlider = TriggerBotTab:CreateSlider({
    Name = "FOV Slider",
    Range = {10, 120},
    Increment = 1,
    Suffix = "°",
    CurrentValue = workspace.CurrentCamera.FieldOfView or 110,
    Flag = "FOVSlider",
    Callback = function(Value)
        workspace.CurrentCamera.FieldOfView = Value
    end,
})

task.spawn(EnforceFOV)

--------------------------------------------------------------------------------
-- Helper function to update the Auto Shoot state and UI label
--------------------------------------------------------------------------------
local function SetAutoShootState(state)
    AutoShootEnabled = state
    StatusLabel.Text = ("Trigger Bot: %s\nAuto Shoot: %s"):format(
        (TriggerBotEnabled and "Enabled" or "Disabled"),
        (AutoShootEnabled and "Enabled" or "Disabled")
    )
end

--------------------------------------------------------------------------------
-- Auto Shoot Toggle
--------------------------------------------------------------------------------
local AutoShootToggle = TriggerBotTab:CreateToggle({
    Name = "Toggle Auto Shoot",
    CurrentValue = false,
    Flag = "AutoShootToggle",
    Callback = function(Value)
        SetAutoShootState(Value)
    end,
})

--------------------------------------------------------------------------------
-- Auto Shoot Keybind (toggles on/off)
--------------------------------------------------------------------------------
local AutoShootKeybind = TriggerBotTab:CreateKeybind({
    Name = "Auto Shoot Keybind",
    CurrentKeybind = "T",
    HoldToInteract = false,
    Flag = "AutoShootKeybind",
    Callback = function()
        local newState = not AutoShootEnabled
        SetAutoShootState(newState)
        
        if AutoShootToggle and AutoShootToggle.SetState then
            AutoShootToggle:SetState(newState)
        end
    end,
})

--------------------------------------------------------------------------------
-- Main loop: checks for Trigger Bot and Auto Shoot
--------------------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    -- Update overlay text if overlay is enabled
    if OverlayEnabled then
        StatusLabel.Text = ("Trigger Bot: %s\nAuto Shoot: %s"):format(
            (TriggerBotEnabled and "Enabled" or "Disabled"),
            (AutoShootEnabled and "Enabled" or "Disabled")
        )
    end

    ----------------------------------------------------------------------------
    -- Trigger Bot (fires when the mouse is over a valid target)
    ----------------------------------------------------------------------------
    if TriggerBotEnabled and Mouse.Target then
        local Target = Mouse.Target
        local Character = Target.Parent
        local TargetPlayer = Players:GetPlayerFromCharacter(Character)
        if TargetPlayer and TargetPlayer ~= LocalPlayer then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                local Camera = workspace.CurrentCamera
                local TargetPosition, onScreen = Camera:WorldToViewportPoint(Humanoid.RootPart.Position)
                if onScreen then
                    VirtualInputManager:SendMouseButtonEvent(TargetPosition.X, TargetPosition.Y, 0, true, game, 0)
                    VirtualInputManager:SendMouseButtonEvent(TargetPosition.X, TargetPosition.Y, 0, false, game, 0)
                end
            end
        end
    end

    ----------------------------------------------------------------------------
    -- Auto Shoot (fires at any enemy on screen if not behind a wall)
    ----------------------------------------------------------------------------
    if AutoShootEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local Humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if Humanoid and Humanoid.Health > 0 and rootPart then
                    local Camera = workspace.CurrentCamera
                    local TargetPosition, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        local origin = Camera.CFrame.Position
                        local direction = rootPart.Position - origin
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                        
                        local rayResult = workspace:Raycast(origin, direction, raycastParams)
                        if rayResult and rayResult.Instance and rayResult.Instance:IsDescendantOf(player.Character) then
                            VirtualInputManager:SendMouseButtonEvent(TargetPosition.X, TargetPosition.Y, 0, true, game, 0)
                            VirtualInputManager:SendMouseButtonEvent(TargetPosition.X, TargetPosition.Y, 0, false, game, 0)
                        end
                    end
                end
            end
        end
    end
end)

Rayfield:LoadConfiguration()
